USE publications;
# Challenge 2

#Step 1
SELECT au.au_id, ti.title_id, (ti.price*sa.qty*(ti.royalty/100)*(tia.royaltyper/100)) 'Sales_Royalty'
FROM authors AS au
JOIN titleauthor AS tia ON au.au_id=tia.au_id
JOIN titles AS ti ON tia.title_id=ti.title_id
JOIN sales AS sa ON sa.title_id=ti.title_id
ORDER BY au.au_id;

#Step 2
SELECT Step1.au_id, Step1.title_id, sum(Sales_Royalty) 'Royalty_Author'
FROM (
SELECT au.au_id, ti.title_id, (ti.price*sa.qty*(ti.royalty/100)*(tia.royaltyper/100)) 'Sales_Royalty'
FROM authors AS au
JOIN titleauthor AS tia ON au.au_id=tia.au_id
JOIN titles AS ti ON tia.title_id=ti.title_id
JOIN sales AS sa ON sa.title_id=ti.title_id
ORDER BY au.au_id) AS Step1
GROUP BY Step1.au_id, Step1.title_id;

#Step 3
CREATE TEMPORARY TABLE Step2
SELECT Step1.au_id, Step1.title_id, sum(Sales_Royalty) 'Royalty_Author'
FROM (
SELECT au.au_id, ti.title_id, (ti.price*sa.qty*(ti.royalty/100)*(tia.royaltyper/100)) 'Sales_Royalty'
FROM authors AS au
JOIN titleauthor AS tia ON au.au_id=tia.au_id
JOIN titles AS ti ON tia.title_id=ti.title_id
JOIN sales AS sa ON sa.title_id=ti.title_id
ORDER BY au.au_id) AS Step1
GROUP BY Step1.au_id, Step1.title_id;

SELECT Step2.au_id, (Step2.Royalty_Author +ti.advance) 'Total_Profit'
FROM Step2
INNER JOIN titles AS ti ON Step2.title_id=ti.title_id
ORDER BY Total_Profit DESC LIMIT 3;

#Challenge 3
CREATE TABLE most_profiting_authors 
SELECT Step2.au_id, (Step2.Royalty_Author +ti.advance) 'Total_Profit'
FROM Step2
INNER JOIN titles AS ti ON Step2.title_id=ti.title_id
ORDER BY Total_Profit DESC LIMIT 10;