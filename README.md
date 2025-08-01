# T&B Food Ordering - README

Welcome to **T&B Food Ordering**, a comprehensive Flutter application designed to solve the real-world operational challenges of a local snack bar. This app provides a streamlined solution for tracking sales, managing supplier settlements, and monitoring financial transactions without the complexity of traditional bookkeeping.

This system is built to empower small food businesses by replacing manual paper-based tracking with a digital, efficient, and accurate tool. It addresses the core need for real-time data and operational clarity, directly impacting profitability and efficiency.

## 🌟 Key Features

*   **Efficient Order Taking**: Simple counter widgets for various plate sizes make it easy to record sales quickly and accurately.
*   **Automated Calculations**: The app automatically calculates total sales, savings, and settlement amounts, minimizing human error.
*   **Centralized Transaction Management**: Uses a **Supabase** backend to log all financial activities, including sales and withdrawals, ensuring data is synced and accessible.
*   **Local State Persistence**: Leverages provider state management to maintain app state, ensuring a smooth user experience even when offline.
*   **Customizable and User-Friendly UI**: Features like a theme toggle for light/dark mode and detailed summary screens enhance usability for all staff members.

## 📱 Screen-by-Screen Functions

### 1. Home Screen 🏠

The **Home Screen** is the central hub for daily sales operations. It features separate columns for "Steam" and "Fried" categories, each with counters for 7-piece, 4-piece, and 8-piece plates.

*(Placeholder for Home Screen image)*

**Core Functions**:
*   **Plate Counting**: Staff can easily increment or decrement the count for each plate type sold using simple counter widgets.
*   **Order Summary**: A detailed summary card displays the total count for each plate size, a grand total of all plates, and the total sales amount in rupees.
*   **State Management**: The screen uses the Provider package to manage the state of the counters, ensuring all data is consistent across the app.

**Real-World Value**: This screen eliminates manual counting and calculation, reducing errors and providing an instant, accurate overview of the day's sales.

### 2. Settlement Screen 📦

The **Settlement Screen** is designed to track and manage payments owed to suppliers for raw materials.

*(Placeholder for Settlement Screen image)*

**Core Functions**:
*   **Supplier Totals**: It calculates and displays the total amount payable to suppliers based on the number of plates sold in both steamed and fried categories.
*   **Detailed Breakdown**: Shows the calculation for different plate sizes, providing transparency in how the final settlement amount is derived.

**Real-World Value**: This simplifies the process of settling accounts with suppliers, ensuring transparency and accuracy in financial dealings. It helps the business owner know exactly how much cash is needed for supplier payments at any given time.

### 3. History Screen 🕓

The **History Screen** provides a log of all transactions, allowing for easy review and tracking.

*(Placeholder for History Screen image)*

**Core Functions**:
*   **Transaction Log**: Displays a chronological list of all financial transactions, including details like the spender, reason, amount, and timestamp.
*   **Categorized View**: Transactions are clearly categorized, and the screen provides actions for managing the history log.

**Real-World Value**: This serves as a digital ledger, providing a clear audit trail of all financial activities, from sales to expenses. It is invaluable for financial reporting and analysis.

### 4. Accounting & Data Management 📈

Instead of a cloud-based real-time P&L, this app uses a robust **Supabase** backend to manage financial data, combined with local state management for a seamless user experience.

**Core Functions**:
*   **Add Transaction Dialog**: A form dialog allows users to add new transactions (like expenses or revenue) directly to the Supabase database.
*   **Withdraw Dialog**: A dedicated dialog for withdrawing funds from revenue, which also integrates directly with Supabase to log the transaction.
*   **Centralized Data**: All critical financial data is stored in a Supabase database, ensuring data integrity and accessibility from different devices if needed.

**Real-World Value**: This setup offers the benefits of a centralized database—like data persistence and synchronization—while providing more control and flexibility than a fully managed BaaS like Firebase. It's a practical solution for a small business that needs reliable data management without a heavy infrastructure overhead.

### 5. Settings Screen ⚙️

The **Settings Screen** provides essential administrative and user-preference functions.

*(Placeholder for Settings Screen image)*

**Core Functions**:
*   **Reset Counters**: A reset button with a confirmation dialog allows for clearing the local counters, useful for starting a new sales day.
*   **Theme Toggle**: Users can switch between light and dark themes to suit their preference and environment.
*   **App Information**: Displays the app version and other relevant information.

**Real-World Value**: This screen provides necessary controls for daily operations and enhances the user experience, making the app adaptable to the specific needs of the snack bar staff.

## 💾 Persistence and State Management Strategy

1.  **Local State Management**: The app uses the **Provider** package along with the `AppState` model to manage the state of counters, transaction history, and theme settings locally. This ensures the app is responsive and functional even without a constant internet connection.
2.  **Backend Database**: **Supabase** is used as the backend to store all critical financial transactions. This provides a persistent, secure, and scalable database solution.
3.  **Data Synchronization**: When a transaction is made (e.g., adding an expense or making a withdrawal), the app communicates with the Supabase backend to ensure the data is saved centrally.

## ⚙️ Tech Stack

*   **Framework**: Flutter
*   **State Management**: Provider
*   **Backend Database**: Supabase
*   **Local Persistence**: JSON serialization for app state

## 🚀 Getting Started

1.  Set up your Supabase project and obtain the necessary API keys.
2.  Configure the Flutter app with your Supabase credentials in the `main.dart` file.
3.  Run the app:
    ```
    flutter pub get
    flutter run
    ```
4.  Begin by setting the prices for different plate types in the relevant constants files.

This application is a testament to how modern development tools can create targeted, high-impact solutions for small businesses, helping them thrive in a competitive market.
