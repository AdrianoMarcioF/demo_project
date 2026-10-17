
CREATE TABLE IF NOT EXISTS public.orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    order_amount NUMERIC(12, 2) NOT NULL,
    status TEXT
);

INSERT INTO public.orders
    (order_id, order_date, customer_id, order_amount, status)
VALUES
    (1, '2024-01-15', 1, 150.00, 'completed'),
    (2, '2024-02-10', 2, 230.50, 'completed'),
    (3, '2024-03-05', 3, 89.90, 'pending')
ON CONFLICT (order_id) DO NOTHING;


CREATE TABLE IF NOT EXISTS public.raw_orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    order_amount NUMERIC(12, 2) NOT NULL,
    status TEXT
);

INSERT INTO public.raw_orders
    (order_id, order_date, customer_id, order_amount, status)
VALUES
    (1, '2024-01-15', 1, 150.00, 'completed'),
    (2, '2024-02-10', 2, 230.50, 'completed'),
    (3, '2024-03-05', 3, 89.90, 'pending')
ON CONFLICT (order_id) DO NOTHING;


CREATE TABLE IF NOT EXISTS public.raw_customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    city TEXT,
    updated_at TIMESTAMP NOT NULL
);

INSERT INTO public.raw_customers
    (customer_id, customer_name, city, updated_at)
VALUES
    (1, 'Customer One', 'Recife', '2024-01-01 10:00:00'),
    (2, 'Customer Two', 'Gravata', '2024-01-02 10:00:00'),
    (3, 'Customer Three', 'Caruaru', '2024-01-03 10:00:00')
ON CONFLICT (customer_id) DO NOTHING;