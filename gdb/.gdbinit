set print pretty on
set trace-commands on
set logging on

define zephyr_thread_print_state
	set $thread_state = ((struct k_thread *)$arg0)->base.thread_state
	if ($thread_state == 1)
		printf "Dummy (1)"
	end
	if ($thread_state == 2)
		printf "Pending (2)"
	end
	if ($thread_state == 4)
		printf "Prestart (4)"
	end
	if ($thread_state == 8)
		printf "Dead (8)"
	end
	if ($thread_state == 16)
		printf "Suspended (16)"
	end
	if ($thread_state == 64)
		printf "Queue (64)"
	end
end

define zephyr_thread_stack
	printf "Thread=%p\n", ((struct k_thread *)$arg0)
	printf "State="
	zephyr_thread_print_state $arg0
	printf "\n"
	printf "PC=%p\n", *(((struct k_thread *)$arg0)->callee_saved.psp + 20)
	l **(((struct k_thread *)$arg0)->callee_saved.psp + 20)
	printf "Stack Ptr=%p\n", ((struct k_thread *)$arg0)->callee_saved.psp
	printf "Stack Frame=%p\n", ((((struct k_thread *)$arg0)->callee_saved.psp) + 20)
	x/32xw ((((struct k_thread *)$arg0)->callee_saved.psp) + 20)
end

define zephyr_show_thread
    printf "State=%d; ", ((struct k_thread *)$arg0)->base.thread_state
    printf "Prio=%d; ", ((struct k_thread *)$arg0)->base.prio
    printf "Entry=%p; ", ((struct k_thread *)$arg0)->entry.pEntry
    printf "PC=%p; ", *(((struct k_thread *)$arg0)->callee_saved.psp + 20)
    printf "PSP=%p; ", ((struct k_thread *)$arg0)->callee_saved.psp + 32

    set $stack_start = ((struct k_thread *)$arg0)->stack_info.start
    set $stack_size = ((struct k_thread *)$arg0)->stack_info.size
    printf "Stack: %p <- %p (%u bytes)", $stack_start, $stack_start + $stack_size, $stack_size
end

define zephyr_list_threads
    set $current_thread = _kernel.threads
    set $idx = 0

    while ($current_thread != 0)
        printf "Thread %02d (%p) ", $idx, $current_thread

        zephyr_show_thread $current_thread

        if ($current_thread == _kernel->current)
            printf " <- RUNNING"
        end
        printf "\n"

        set $PC = *(((struct k_thread *)$current_thread)->callee_saved.psp + 20)
        printf "\t"
        info line *$PC

        set $idx = $idx + 1
        set $current_thread = $current_thread->next_thread
    end
end

define zephyr_show_pkt
	printf "pkt=%p; ", ((struct net_pkt *)$arg0)
	printf "ref=%d; ", ((struct net_pkt *)$arg0)->ref
end

define zephyr_show_pkt_alloc
	printf "is_pkt=%d; ", ((struct net_pkt_alloc *)$arg0)->is_pkt
	printf "is_used=%d; ", ((struct net_pkt_alloc *)$arg0)->in_use
	printf "alloc=%s:%d; ", ((struct net_pkt_alloc *)$arg0)->func_alloc, ((struct net_pkt_alloc *)$arg0)->line_alloc
	printf "free=%s:%d; ", ((struct net_pkt_alloc *)$arg0)->func_free, ((struct net_pkt_alloc *)$arg0)->line_free
end

define zephyr_list_pkt
	set $idx = 0

	while ($idx < $arg0)
		printf "Packet %d: ", $idx
		zephyr_show_pkt_alloc &net_pkt_allocs[$idx]
		printf "\n\t"
		zephyr_show_pkt &(net_pkt_allocs[$idx]->pkt)
		printf "\n"
		set $idx = $idx + 1
	end
end
