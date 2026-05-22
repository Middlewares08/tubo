-- Categories
CREATE TABLE categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  type text CHECK (type IN ('sale','expense')),
  created_at timestamptz DEFAULT now()
);

-- Transactions (sales + expenses)
CREATE TABLE transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type text NOT NULL CHECK (type IN ('sale','expense')),
  amount numeric(10,2) NOT NULL,
  category_id uuid REFERENCES categories(id),
  note text,
  created_at timestamptz DEFAULT now()
);

-- Inventory items
CREATE TABLE inventory_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  stock numeric(10,2) DEFAULT 0,
  unit text DEFAULT 'pcs',
  cost_price numeric(10,2),
  selling_price numeric(10,2),
  low_stock_threshold numeric(10,2) DEFAULT 5,
  updated_at timestamptz DEFAULT now()
);

-- Seed default categories
INSERT INTO categories (name, type) VALUES
  ('Food & drinks','sale'),
  ('Supplies','expense'),
  ('Utilities','expense'),
  ('Salary','expense');