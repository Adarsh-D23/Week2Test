with t1 as
		(SELECT *,(fiscal_year%10) as last_digit, row_number() over(ORDER BY company) as id,
		(row_number() over(ORDER BY company)-(fiscal_year%10)) as flag  FROM dividend),
	t2 as
		(SELECT *,count(*) over(partition by flag) as result from t1)


SELECT JSON_AGG(DISTINCT company) AS valuestocks FROM t2 
WHERE result>=3 ;