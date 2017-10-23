DROP TABLE IF EXISTS burger_deals;
DROP TABLE IF EXISTS burgers;
DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS eateries;

CREATE TABLE eateries(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  url VARCHAR(255)
);

CREATE TABLE deals(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  day INT4,
  discount_decimal NUMERIC,
  eatery_id INT4 REFERENCES eateries(id)
);

CREATE TABLE burgers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  price NUMERIC,
  eatery_id INT4 REFERENCES eateries(id)
);

CREATE TABLE burger_deals(
  id SERIAL4 PRIMARY KEY,
  deal_id INT4 REFERENCES deals(id),
  burger_id INT4 REFERENCES burgers(id)
);
