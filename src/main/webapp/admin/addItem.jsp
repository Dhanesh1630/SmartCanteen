<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Menu Item - Smart Canteen</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 20px;
    }

    .container {
        width: 100%;
        max-width: 500px;
    }

    .card {
        padding: 45px;
        border-radius: 20px;
        background: rgba(255, 255, 255, 0.95);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 30px;
        font-size: 28px;
        font-weight: 700;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: #333;
        font-weight: 600;
        font-size: 14px;
    }

    input,
    select {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e0e0e0;
        outline: none;
        border-radius: 10px;
        font-size: 14px;
        background: rgba(255, 255, 255, 0.95);
        color: #333;
        transition: all 0.3s ease;
    }

    input:focus,
    select:focus {
        border-color: #667eea;
        box-shadow: 0 0 10px rgba(102, 126, 234, 0.2);
    }

    input::placeholder {
        color: #999;
    }

    button {
        width: 100%;
        padding: 14px;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        margin-top: 10px;
    }

    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
    }

    button:active {
        transform: translateY(0);
    }

    .back-btn {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background: rgba(102, 126, 234, 0.2);
        border-radius: 8px;
        color: #667eea;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.3s ease;
        border: 1px solid rgba(102, 126, 234, 0.3);
        width: fit-content;
    }

    .back-btn:hover {
        background: rgba(102, 126, 234, 0.3);
        transform: translateX(-3px);
    }

    .button-group {
        display: flex;
        justify-content: center;
    }

    @media (max-width: 480px) {
        .card {
            padding: 35px 25px;
        }
        
        h2 {
            font-size: 24px;
        }
    }
</style>

</head>
<body>

<div class="container">
    <div class="card">
        <h2>➕ Add New Menu Item</h2>

        <form action="<%= request.getContextPath() %>/AddItemServlet" method="post">

            <div class="form-group">
                <label for="item_name">Item Name</label>
                <input type="text" id="item_name" name="item_name" placeholder="Enter item name" required>
            </div>

            <div class="form-group">
                <label for="price">Price (₹)</label>
                <input type="number" id="price" name="price" step="0.01" placeholder="Enter price" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" id="category" name="category" placeholder="e.g., Snacks, Beverages" required>
            </div>

            <div class="form-group">
                <label for="available">Availability</label>
                <select id="available" name="available" required>
                    <option value="yes">✓ Available</option>
                    <option value="no">✗ Out of Stock</option>
                </select>
            </div>

            <button type="submit">✅ Add Item</button>

        </form>

        <div class="button-group">
            <a class="back-btn" href="../adminDashboard.jsp">⬅ Back to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>
