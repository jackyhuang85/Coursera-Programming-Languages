fun convert_to_days (d : int * int * int) =
  (#1 d) * 365 + (#2 d) * 30 + (#3 d)

fun is_older (d1 : int * int * int, d2 : int * int * int) =
  if (convert_to_days(d1)) >= (convert_to_days(d2))
  then false
  else true

fun number_in_month (dlist : (int * int * int) list, m : int) =
  if null dlist
  then 0
  else (
    if (#2 (hd dlist)) = m
    then 1 + number_in_month(tl dlist, m)
    else 0 + number_in_month(tl dlist, m)
  )

fun number_in_months (dlist : (int * int * int) list, mlist: int list) =
  if null mlist
  then 0
  else number_in_month(dlist, hd mlist) + number_in_months(dlist, tl mlist)

fun dates_in_month (dlist : (int * int * int) list, m : int) =
  if null dlist
  then nil
  else (
    if (#2 (hd dlist)) = m
    then (hd dlist)::(dates_in_month(tl dlist, m))
    else (dates_in_month(tl dlist, m))
  )

fun dates_in_months (dlist : (int * int * int) list, mlist : int list) =
  if null mlist
  then nil
  else (dates_in_month(dlist, hd mlist))@(dates_in_months(dlist, tl mlist))

fun get_nth (slist : string list, n : int) = 
  if n = 1
  then (hd slist)
  else get_nth(tl slist, n-1)

fun date_to_string (date : int * int * int) =
  let val months_string = ["January", "February", "March", "April", "May", "June", "July",
  "August", "September", "October", "November", "December"]
  in
    get_nth(months_string, (#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", " ^
    Int.toString(#1 date)
  end

fun number_before_reaching_sum (sum : int, numbers : int list) = 
  if null numbers
  then 0
  else (
    if sum > (hd numbers)
    then (1 + number_before_reaching_sum (sum-(hd numbers), tl numbers))
    else 0
  )

fun what_month (day : int) = 
  let val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum (day, days_in_months) + 1
  end

fun month_range (day1 : int, day2 : int) =
  if day1 > day2
  then nil
  else (
    let val m = what_month(day1)
    in
      ([m]@(month_range(day1+1, day2)))
    end
  )

fun oldest (dlist : (int * int * int) list) =
  if null dlist
  then NONE
  else (
    let fun oldest_nonempty (dlist : (int * int * int) list) =
      if null (tl dlist)
      then (hd dlist)
      else (
        let val tl_ans = oldest_nonempty(tl dlist)
        in
          if is_older(hd dlist, tl_ans)
          then hd dlist
          else tl_ans
        end
      )
    in
      SOME (oldest_nonempty(dlist))
    end
  )
