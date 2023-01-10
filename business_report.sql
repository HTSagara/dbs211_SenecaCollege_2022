--DROP VIEW BRANDS;
--DROP VIEW TOP_BRANDS;
--DROP VIEW TOP_PRODUCTS_PER_CATEGORY;
--DROP VIEW LOW_PRODUCT_CATEGORIES;

------------------------------------------------------------------------

-- Business Reports: A single SQL file providing the scripting to create at least 4 VIEWS, 
-- that provide a report on the data that support the business, or organization, in making informed business decisions.   
-- Each report should have a paragraph writeup – in comment form, 
-- that explain the purpose of the report and how the business will benefit from having the report.

------------------------------------------------------------------------

-- ## Get a list of all brands and their categories
-- Developers can use this information to create a search by brand tab.
-- Users benefit from this feature if they want to search for products by brand.
-- This report will also be useful if we want to create further analysis for each brand

CREATE OR REPLACE VIEW brands AS 
SELECT DISTINCT
    product_brand as brand,
    category_id as category 
FROM
    products 
ORDER BY
    product_brand;



-- ## Get the brands who have an average rating of 4.0 and above across all their products.
-- This will help the developers analyze what brands have the highest customer satisfaction and product quality.
-- Developers can use this information to recommend top brands to users.
-- Users can use this information to search for products by the most trusted brand.
-- Brands benefit from this as they can use this information to analyze how they stand up against brands.

CREATE OR REPLACE VIEW top_brands AS 
SELECT
    product_brand as brand,
    ROUND(AVG(product_rating), 1) as rating 
FROM
    products 
    LEFT JOIN
        (
            SELECT
                product_id,
                ROUND(AVG(rating), 1) product_rating 
            FROM
                comments 
            GROUP BY
                product_id
        )
        USING (product_id) 
GROUP BY
    product_brand 
HAVING
    ROUND(AVG(product_rating), 1) >= 4;



-- ## Get the top rated product for each category
-- Developers can use this information to create a showcase section in their front page where the top rated products for each
-- category can be found.
-- Users benefit from this becaues they could easily find the best product for each category right in their home page
-- Brands benefit from this as they get to see their products' competition or will get to see increased sales if their product
-- reaches the showcase section.

CREATE OR REPLACE VIEW top_products_per_category AS
SELECT
    category_name,
    product_name,
    product_brand,
    product_rating 
FROM
    products 
    LEFT JOIN
        (
            -- gets the rating for each product
            SELECT
                product_id,
                ROUND(AVG(rating), 1) product_rating 
            FROM
                comments 
            GROUP BY
                product_id 
        )
        USING (product_id) 
    LEFT JOIN
        (
            -- gets the top rating per category
            SELECT
                category_id,
                MAX(product_rating) as topRating 
            FROM
                products 
                LEFT JOIN
                    (
                        SELECT
                            product_id,
                            ROUND(AVG(rating), 1) product_rating 
                        FROM
                            comments 
                        GROUP BY
                            product_id
                    )
                    USING (product_id) 
            GROUP BY
                category_id 
        )
        USING (category_id) 
    LEFT JOIN
        -- gets the whole category table
        categories USING (category_id) 
WHERE
    product_rating = topRating 
ORDER BY
    category_id;
    


-- ## Get the categories with the least number of products
-- Developers can use this information to gauge what categories need more products and who to reach out to in order
-- to fill up these lacking areas.

CREATE OR REPLACE VIEW low_product_categories AS
SELECT
    category_id,
    category_name,
    product_count
FROM
    categories 
    JOIN
        (
            SELECT
                category_id,
                COUNT(category_id) product_count
            FROM
                products 
            GROUP BY
                category_id 
            HAVING
                COUNT(category_id) = 
                (
                    SELECT
                        MIN(COUNT(category_id)) 
                    FROM
                        products 
                    GROUP BY
                        category_id
                )
            ORDER BY
                category_id
        )
        USING(category_id);


