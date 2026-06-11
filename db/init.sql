-- Create database if not exists
CREATE DATABASE IF NOT EXISTS expense_system_development CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS expense_system_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges to expense_user on both databases (development is granted by compose environment, but doing it here ensures test database access too)
GRANT ALL PRIVILEGES ON expense_system_development.* TO 'expense_user'@'%';
GRANT ALL PRIVILEGES ON expense_system_test.* TO 'expense_user'@'%';
FLUSH PRIVILEGES;