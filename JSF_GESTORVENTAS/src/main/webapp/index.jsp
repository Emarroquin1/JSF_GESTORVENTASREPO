<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
 
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<jsp:include page="styles.jsp" />
</head>
 
<style>
@charset "UTF-8";*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}
body{
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: url(fondoLogin2.jpg) no-repeat;
  background-size: cover;
  background-position: center;
}
.wrapper{
  width: 420px;
  background: transparent;
  border: 2px solid rgba(255, 255, 255, .2);
  backdrop-filter: blur(9px);
  color: #fff;
  border-radius: 12px;
  padding: 30px 40px;
}
.wrapper h1{
  font-size: 36px;
  text-align: center;
}
.wrapper .input-box{
  position: relative;
  width: 100%;
  height: 50px;
  
  margin: 30px 0;
}
.input-box input{
  width: 100%;
  height: 100%;
  background: transparent;
  border: none;
  outline: none;
  border: 2px solid rgba(255, 255, 255, .2);
  border-radius: 40px;
  font-size: 16px;
  color: #fff;
  padding: 20px 45px 20px 20px;
}
.input-box input::placeholder{
  color: #fff;
}
.input-box i{
  position: absolute;
  right: 20px;
  top: 30%;
  transform: translate(-50%);
  font-size: 20px;

}
.wrapper .remember-forgot{
  display: flex;
  justify-content: space-between;
  font-size: 14.5px;
  margin: -15px 0 15px;
}
.remember-forgot label input{
  accent-color: #fff;
  margin-right: 3px;

}
.remember-forgot a{
  color: #fff;
  text-decoration: none;

}
.remember-forgot a:hover{
  text-decoration: underline;
}
.wrapper .btn{
  width: 100%;
  height: 45px;
  background: #fff;
  border: none;
  outline: none;
  border-radius: 40px;
  box-shadow: 0 0 10px rgba(0, 0, 0, .1);
  cursor: pointer;
  font-size: 16px;
  color: #333;
  font-weight: 600;
}
.wrapper .register-link{
  font-size: 14.5px;
  text-align: center;
  margin: 20px 0 15px;

}
.register-link p a{
  color: #fff;
  text-decoration: none;
  font-weight: 600;
}
.register-link p a:hover{
  text-decoration: underline;
}
</style>

<body>
 <div class="wrapper">
    
      <h1>Login</h1>
      <div class="input-box">
        <input id="txtCorreo"  type="text" placeholder="Username" required>
        <i class='bx bxs-user'></i>
      </div>
      <div class="input-box">
        <input id="txtPassword" type="password" placeholder="Password" required>
        <i class='bx bxs-lock-alt' ></i>
      </div>
      <button id="btnLogin"  class="btn">Iniciar Sesión</button>  
    
  </div>
</body>
	<!-- Incluye los scripts necesarios, como jQuery, Bootstrap y SweetAlert -->
	<jsp:include page="scripts.jsp" />
</html>

    <script>

		
			document.addEventListener('DOMContentLoaded', function () {
			    var usuarioGuardado = JSON.parse(localStorage.getItem("usuario"));
			    console.log(usuarioGuardado);

			    // Verifica si el usuarioGuardado no es null
			    if (usuarioGuardado !== null) {
			        // Redirige a otra página JSP
			        window.location.href = 'negocio.jsp';
			    }
			});


	
        document.getElementById('btnLogin').addEventListener('click', function() {
            // Obtener los valores de las cajas de texto
            var correo = document.getElementById('txtCorreo').value;
            var password = document.getElementById('txtPassword').value;

            // Realizar la solicitud AJAX
            $.ajax({
                type: "POST",
                url: "procesarData.jsp", // Ajusta la URL
                data: {
                    key: "loginUsuario",
                    correo: correo,
                    password: password
                },
                success: function(data) {
                 

                    // Procesar la respuesta del servidor
                    if (data.tipo === "éxito") {
                    	  var usuario = data.usuario;

                    	  // Almacenar el objeto de usuario en localStorage
                          localStorage.setItem("usuario", JSON.stringify(usuario));
             

                          Swal.fire({
                              icon: 'success',
                              title: 'Inicio de Sesión exitoso!',
                              text: 'Bienvenido: ' + usuario.correo,
                              showConfirmButton: true,
                          }).then((result) => {
                              // This code will be executed after the user clicks on the "OK" button
                              if (result.isConfirmed) {
                                  usuarioGuardado = JSON.parse(localStorage.getItem("usuario"));
                                  console.log(usuarioGuardado);
                                  window.location.href = 'negocio.jsp';
                              }
                          });

                        // Hacer algo después de un inicio de sesión exitoso
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error en el login: ' + data.mensaje
                        });
                    }
                },
                error: function(error) {
                    console.log("Error en la solicitud AJAX: " + error);
                }
            });
        });
    </script>

