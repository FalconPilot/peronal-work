let calculator n1 op n2 =
	if op == '+' then n1 + n2
	else if op == '-' then n1 - n2
	else if op == '*' then n1 * n2
	else if op == '/' then n1 / n2

let main () =
	let n1 = read_int () in
	let op = read_line () in
	let n2 = read_int () in
	print_int calculator(n1 op n2)

let () = main ()
