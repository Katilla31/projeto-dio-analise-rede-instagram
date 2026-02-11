MATCH (a:Account)-[:POSTED]->(p:Post)
RETURN a.account_id, 
       sum(p.likes) AS total_likes, 
       count(p) AS total_posts
ORDER BY total_likes DESC 
LIMIT 10;

MATCH (p:Post)-[:BELONGS_TO]->(c:Category)
RETURN c.name AS Comunidade, 
       count(p) AS total_posts, 
       avg(p.engagement_rate) AS engajamento_medio
ORDER BY engajamento_medio DESC;

MATCH (p:Post)
RETURN p.media_type, 
       avg(p.engagement_rate) AS media_engajamento, 
       sum(p.reach) AS alcance_total
ORDER BY media_engajamento DESC;

MATCH (n) RETURN labels(n), count(n);

LOAD CSV WITH HEADERS FROM 'https://github.com/Katilla31/analise-redes-sociais/raw/refs/heads/main/Instagram_Analytics.csv' AS row

MERGE (a:Account {account_id: row.account_id})
ON CREATE SET 
    a.type = row.account_type,
    a.followers = toInteger(row.follower_count)

MERGE (c:Category {name: row.content_category})

MERGE (p:Post {post_id: row.post_id})
ON CREATE SET 
    p.media_type = row.media_type,
    p.likes = toInteger(row.likes),
    p.comments = toInteger(row.comments),
    p.shares = toInteger(row.shares),
    p.reach = toInteger(row.reach),
    p.engagement_rate = toFloat(row.engagement_rate),
    p.performance = row.performance_bucket_label

MERGE (a)-[:POSTED]->(p)
MERGE (p)-[:BELONGS_TO]->(c);

CREATE INDEX category_name_index IF NOT EXISTS 
FOR (c:Category) ON (c.name);

CREATE CONSTRAINT account_unique IF NOT EXISTS 
FOR (a:Account) REQUIRE a.account_id IS UNIQUE;

CREATE CONSTRAINT post_unique IF NOT EXISTS 
FOR (p:Post) REQUIRE p.post_id IS UNIQUE;

LOAD CSV WITH HEADERS FROM 'https://github.com/Katilla31/analise-redes-sociais/raw/refs/heads/main/Instagram_Analytics.csv' AS row
WITH row
WHERE row.post_id IS NULL OR row.account_id IS NULL OR row.content_category IS NULL
RETURN count(*) AS linhas_com_erro;

LOAD CSV WITH HEADERS FROM 'https://github.com/Katilla31/analise-redes-sociais/raw/refs/heads/main/Instagram_Analytics.csv' AS row
WITH row.post_id AS id, count(*) AS total
WHERE total > 1
RETURN id, total;