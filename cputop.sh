#!/bin/bash

cputop () 
{
	ps -eo pid,ppid,ucmd,pmem,pcpu --sort=-%cpu | head -23
}

cputo
