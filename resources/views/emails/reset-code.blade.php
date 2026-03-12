<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset Code</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f7;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            background-color: #dc3545;
            color: #ffffff;
            text-align: center;
            padding: 30px 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .content {
            padding: 30px 40px;
            text-align: center;
        }
        .content p {
            color: #555555;
            font-size: 16px;
            line-height: 1.6;
        }
        .code-box {
            display: inline-block;
            background-color: #f8f9fa;
            border: 2px dashed #dc3545;
            border-radius: 8px;
            padding: 15px 40px;
            margin: 20px 0;
            font-size: 36px;
            font-weight: bold;
            letter-spacing: 8px;
            color: #dc3545;
        }
        .warning {
            color: #999999;
            font-size: 13px;
            margin-top: 20px;
        }
        .footer {
            background-color: #f8f9fa;
            text-align: center;
            padding: 15px;
            color: #999999;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚑 Smart Ambulance</h1>
        </div>
        <div class="content">
            <p>You have requested to reset your password.</p>
            <p>Use the following code to verify your identity:</p>
            <div class="code-box">{{ $code }}</div>
            <p class="warning">This code is valid for <strong>10 minutes</strong>.<br>If you did not request this, please ignore this email.</p>
        </div>
        <div class="footer">
            &copy; {{ date('Y') }} Smart Ambulance System. All rights reserved.
        </div>
    </div>
</body>
</html>
