@echo off
echo Library Management System Demo Launcher
echo ---------------------------------------
echo This script will start the Library Management System in database-free demo mode.
echo.

echo Setting up environment...
set RAILS_ENV=development
set DISABLE_DATABASE=true
set DEMO_MODE=true

echo.
echo Starting Rails server...
echo.
echo When the server starts, navigate to http://localhost:3000 in your web browser.
echo.
echo Demo login credentials:
echo - Student: student@example.com / password
echo - Librarian: librarian@example.com / password  
echo - Admin: admin@example.com / password
echo.
echo Press Ctrl+C to stop the server when done.
echo.

rails server -p 3000

echo.
echo Server stopped. Thank you for using the Library Management System demo.
pause 