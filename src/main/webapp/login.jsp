<div class="login-container" style="max-width: 400px; margin: 100px auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
    <h2 style="text-align: center; color: #2c3e50;">Admin Login</h2>
    <form action="AdminLoginServlet" method="POST">
        <div class="input-group" style="margin-bottom: 20px;">
            <input type="text" name="username" placeholder="Username" required style="width:100%; padding:12px; border:1px solid #ddd; border-radius:5px;">
        </div>
        <div class="input-group" style="margin-bottom: 20px;">
            <input type="password" name="password" placeholder="Password" required style="width:100%; padding:12px; border:1px solid #ddd; border-radius:5px;">
        </div>
        <button type="submit" style="width:100%; background:#f39c12; color:white; border:none; padding:12px; border-radius:5px; font-weight:bold; cursor:pointer;">Login</button>
    </form>
</div>