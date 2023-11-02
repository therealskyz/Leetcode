-- 1757. Recyclable and Low Fat Products
SELECT product_id FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y'

-- 584. Find Customer Referee
SELECT name FROM Customer
WHERE referee_id != 2 or referee_id IS NUll

-- 595. Big Countries
SELECT name, population, area FROM World
WHERE area >= 3000000 or population >= 25000000

-- 1148. Article Views I
SELECT DISTINCT(author_id) AS id FROM Views
WHERE author_id = viewer_id
ORDER BY id

-- 1683. Invalid Tweets
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15

-- 1378. Replace Employee ID With The Unique Identifier
SELECT u.unique_id, e.name FROM Employees e
Left Join EmployeeUNI u
ON e.id = u.id

-- 1068. Product Sales Analysis I
SELECT p.product_name, s.year, s.price FROM Sales s
JOIN Product p 
ON s.product_id = p.product_id

-- 1581. Customer Who Visited but Did Not Make Any Transactions
SELECT v.customer_id, count(v.customer_id) AS count_no_trans FROM Visits v
LEFT JOIN Transactions t
ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY v.customer_id
ORDER BY count_no_trans

-- 197. Rising Temperature
SELECT w1.id FROM Weather w1 
JOIN Weather w2
-- Self join without ON clause matches every record from w1 with every record of w2, i.e. Implicit Join
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.temperature > w2.temperature

-- 1661. Average Time of Process per Machine
SELECT s.machine_id, ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time FROM Activity s
JOIN Activity e
ON
    s.machine_id = e.machine_id AND s.process_id = e.process_id
    AND s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY s.machine_id

-- 577. Employee Bonus
SELECT e.name, b.bonus FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL
GROUP BY e.empId

-- 1280. Students and Examinations
SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) AS attended_exams FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, sub.subject_name
ORDER BY s.student_id, sub.subject_name

-- 570. Managers with at Least 5 Direct Reports
SELECT e1.name FROM Employee e1
JOIN Employee e2
ON e1.id = e2.managerId
GROUP BY e1.id
HAVING COUNT(e2.managerId) >= 5

-- 1934. Confirmation Rate
SELECT user_id, ROUND(AVG(temp), 2) AS confirmation_rate FROM (SELECT s.user_id, c.action, 
CASE
  WHEN c.action = 'timeout' THEN 0
  WHEN c.action = 'confirmed' THEN 1
  WHEN c.action IS NULL THEN 0
END AS temp
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id) temp2
GROUP BY user_id

-- 620. Not Boring Movies
SELECT id, movie, description, rating FROM Cinema
WHERE description != "boring" AND id % 2 != 0
ORDER BY rating DESC;

-- 1251. Average Selling Price
SELECT p.product_id, IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id AND u.purchase_date BETWEEN start_date AND end_date
GROUP BY p.product_id

-- 1075. Project Employees I
SELECT p.project_id, ROUND(AVG(e.experience_years), 2) AS average_years FROM Project p
JOIN Employee e
ON p.employee_id = e.employee_id
GROUP BY p.project_id

-- 1633. Percentage of Users Attended a Contest
SELECT r.contest_id, ROUND(COUNT(u.user_id) / (SELECT COUNT(*) FROM Users) * 100, 2) AS percentage FROM Users u 
JOIN Register r 
ON u.user_id = r.user_id
GROUP BY r.contest_id
ORDER BY percentage DESC, contest_id ASC

-- 1211. Queries Quality and Percentage
SELECT query_name, ROUND(AVG(rating/position), 2) AS quality, ROUND(AVG(rating < 3) * 100, 2) AS poor_query_percentage FROM Queries
GROUP BY query_name

-- 1193. Montly Transactions I
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, COUNT(trans_date) AS trans_count, COUNT(CASE WHEN state = 'approved' THEN state END) AS approved_count, SUM(amount) AS trans_total_amount, SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country

-- 1174. Immediate Food Delivery II
SELECT ROUND(AVG(order_date = customer_pref_delivery_date) * 100, 2) AS immediate_percentage FROM Delivery
WHERE (customer_id, order_date) IN (SELECT customer_id, MIN(order_date) AS first_order_date FROM Delivery
GROUP BY customer_id)

-- 550. Game Play Analysis IV
SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction FROM Activity
WHERE (player_id, event_date) IN (SELECT player_id, DATE_ADD(MIN(event_date), INTERVAL 1 DAY) FROM Activity
GROUP BY player_id)

-- 2356. Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher
GROUP BY teacher_id

-- 1141. User Activity for the Past 30 Days I
SELECT activity_date as day, COUNT(DISTINCT user_id) AS active_users FROM Activity
WHERE activity_date < '2019-07-27' AND activity_date > '2019-06-27'
GROUP BY activity_date

-- 1070. Product Sales Analysis III
SELECT product_id, year AS first_year, quantity, price FROM Sales
WHERE (product_id, year) IN (SELECT product_id, MIN(year) FROM Sales
GROUP BY product_id)

-- 596. Classes More Than 5 Students
SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5

-- 1729. Find Followers Count
SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers
GROUP BY user_id
ORDER BY user_id 

-- 619. Biggest Single Number
SELECT MAX(num) AS num FROM MyNumbers
WHERE num IN (SELECT num FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1)

-- 1045. Customers Who Bought All Products
SELECT customer_id FROM Customer
GROUP BY customer_id
HAVING SUM(DISTINCT product_key) = (SELECT SUM(product_key) FROM Product)

-- 1731. The Number of Employees Which Report to Each Employee
SELECT e1.employee_id, e1.name, COUNT(e1.employee_id) AS reports_count, ROUND(AVG(e2.age)) AS average_age FROM Employees e1
JOIN Employees e2
ON e1.employee_id = e2.reports_to
GROUP BY e1.employee_id
ORDER BY e1.employee_id

-- 1789. Primary Department for Each Employee
SELECT employee_id, department_id FROM Employee
GROUP BY employee_id
HAVING COUNT(department_id) = 1
UNION
SELECT employee_id, department_id FROM Employee
WHERE primary_flag = 'Y'
GROUP BY employee_id
ORDER BY employee_id

-- 610. Triangle Judgement
SELECT x, y, z,
CASE WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No'
END AS triangle
FROM Triangle

-- OR
SELECT x, y, z, 
IF(x + y > z AND x + z > y AND y + z > x, "Yes", "No") AS triangle FROM Triangle

-- 180. Consecutive Numbers
WITH cte AS(
  SELECT num, LEAD(num, 1) OVER() AS num1, LEAD(num, 2) OVER() AS num2 FROM Logs
)

SELECT DISTINCT num AS ConsecutiveNums FROM cte
WHERE num = num1 AND num = num2

-- 1164. Product Price at a Given Date
SELECT product_id, FIRST_VALUE(new_price) OVER(PARTITION BY product_id ORDER BY change_date DESC) AS price FROM Products
WHERE change_date <= '2019-08-16'
UNION
SELECT DISTINCT product_id, 10 AS price FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Products
WHERE change_date <= '2019-08-16')

-- 1204. Last Person to Fit in the Bus
WITH cte AS (
  SELECT *, SUM(weight) OVER(ORDER BY turn) AS Total_Weight FROM Queue
)

SELECT person_name FROM cte
WHERE Total_Weight <= 1000
ORDER BY Total_Weight DESC
LIMIT 1

-- 1907. Count Salary Categories
WITH cte AS (SELECT
CASE 
  WHEN income > 50000 THEN "High Salary"
  WHEN income >= 20000 AND income <= 50000 THEN "Average Salary"
  ELSE "Low Salary"
  END AS category
FROM Accounts
UNION ALL
SELECT "High Salary" AS category
UNION ALL
SELECT 'Low Salary' AS category
UNION ALL
SELECT 'Average Salary' AS category
)

SELECT category, COUNT(category) - 1 AS accounts_count FROM cte
GROUP BY category

-- 1978. Employees Whose Manager Left the Company
SELECT employee_id FROM Employees
WHERE salary < 30000 AND manager_id NOT IN (SELECT DISTINCT employee_id FROM Employees)
ORDER BY employee_id

-- 1341. Movie Rating
SELECT 
CASE WHEN id % 2 != 0 AND id = (SELECT COUNT(id) FROM Seat) THEN id
     WHEN id % 2 = 0 THEN id - 1 
     WHEN id % 2 != 0 THEN id + 1
END AS id, 
student FROM Seat
ORDER BY id

-- 1321. Restaurant Growth
SELECT DISTINCT visited_on, amount, ROUND(amount/7, 2) AS average_amount 
FROM (
  SELECT visited_on,
         SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount FROM Customer
) t
WHERE DATEDIFF(t.visited_on, (SELECT MIN(visited_on) FROM Customer)) >= 6

-- 1341. Movie Rating
WITH gn_movies AS (SELECT name, COUNT(movie_id) AS results FROM MovieRating mr
JOIN Users u
ON mr.user_id = u.user_id
GROUP BY name
ORDER BY results DESC, name 
LIMIT 1
),
high_avg AS (SELECT title, mr.movie_id, AVG(rating) AS avg_rating FROM MovieRating mr
JOIN Movies m
ON mr.movie_id = m.movie_id
where created_at between '2020-02-01' and '2020-02-28'
GROUP BY title
ORDER BY avg_rating DESC, title
LIMIT 1
)

SELECT name AS results FROM gn_movies
UNION ALL
SELECT title as results FROM high_avg 

-- 1321. Restaurant Growth
SELECT DISTINCT visited_on, amount, ROUND(amount/7, 2) AS average_amount 
FROM (
  SELECT visited_on,
         SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount FROM Customer
         ) t
WHERE DATEDIFF(t.visited_on, (SELECT MIN(visited_on) FROM Customer)) >= 6

-- 602. Friend Requests II: Who Has the Most Friends
SELECT requester_id AS id,
       (SELECT Count(*)
        FROM requestaccepted
        WHERE (requester_id = id
                  OR accepter_id = id)) AS num
FROM requestaccepted
GROUP BY requester_id
UNION
SELECT accepter_id AS id,
       (SELECT Count(*)
        FROM requestaccepted
        WHERE (requester_id = id
                  OR accepter_id = id)) AS num
FROM requestaccepted
GROUP BY accepter_id
ORDER BY num DESC

-- 585. Investments in 2016
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM insurance
WHERE tiv_2015 IN (SELECT tiv_2015
                    FROM insurance
                    GROUP BY tiv_2015
                    HAVING COUNT(tiv_2015) > 1)
       AND (lat, lon) NOT IN (SELECT lat, lon
                                FROM insurance
                                GROUP BY lat, lon
                                HAVING COUNT(*) > 1) 

-- 185. Department Top Three Salaries
WITH cte AS (
  SELECT d.name AS Department, e.name AS Employee, salary, 
  DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.Salary DESC) AS rk FROM Employee e
  JOIN Department d
  ON e.departmentId = d.id
)

SELECT Department, Employee, salary AS Salary FROM cte
WHERE rk <= 3
