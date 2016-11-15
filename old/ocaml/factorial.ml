(* First Ocaml tail recursive test *)

let factorial n =
	let rec fact_acc n acc =
		if n <= 1 then acc
		else fact_acc (n - 1) (acc * n)
	in fact_acc n 1

let main () =
	let num = read_int () in
		print_int (factorial num);
		print_char ('\n')

let () = main ()
