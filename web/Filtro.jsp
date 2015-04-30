<%-- 
    Document   : Filtro
    Created on : 6/03/2015, 09:52:44 AM
    Author     : Usuraio
--%>

<%@page import="Controlador.FacadePersonas"%>
<%@page import="co.sena.edu.booking.DAO.personasDAO"%>
<%@page import="co.sena.edu.booking.DTO.listarPerDTO"%>
<%@page import="co.sena.edu.booking.DTO.personasDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


        <link type="text/css" rel="stylesheet" href="bootstrap-3.2.0-dist/bootstrap-3.2.0-dist/css/bootstrap.css">
        <link type="text/css" rel="stylesheet" href="css/css.css">
        <link rel="shortcut icon" href="imagenes/br.ico" />
        <script src="scripts/registro.js" type="text/javascript"></script>
        <script src="scripts/ingreso.js" type="text/javascript"></script>
        <script src="scripts/bookasp.js" type="text/javascript"></script>

        <title>Filtro Multicriterio</title>

    </head>
    <body>

        <div class ="contenedor">
            <div class="banner"> 
                <p><a href="Index.html"><img src="imagenes/Logo.png" alt="Booking Routers" width="1360" height="126" title="Forget the rest, call the best"  /></a></p>
            </div>
            
            <nav>
  <ul id="main">
  <li><div align="center"><a href="#" style="text-decoration: none;"><span class="glyphicon glyphicon-send"></span> Gestion Rutas</a>
  <ul class="submain">
  <li><a href="CreaRuta.jsp?msj=" style="text-decoration: none;">Creación de Rutas</a></li>
  <li><a href="ModRuta.jsp?msj=" style="text-decoration: none;">Modificación de Rutas</a> </li>
  </ul>
  </div>  
  </li>  
  <li><div align="center"><a href="verificarRegistro.jsp" style="text-decoration: none;"><span class="glyphicon glyphicon-folder-open"></span> Registros</a> 
  </li>
 <li><div align="center"><a href="Index.html" style="text-decoration: none;"><span class="glyphicon glyphicon-remove-sign"></span> Cerrar sesion</li></a>
 </ul>
  </nav>
            
            <br>
        
            <center>
                <div class="col-md-6" ><h2>Búsqueda de Usuarios</h2></div>
               
                <form action="buscarPersona" method="post">
                    <table>
        
         <tr>
            <td>
                <br>
                <strong>Pais</strong><font color="#FF0000">*</font>
                <br>
            </td>
            <td> <input type="text" name="nombre"  class="form-control inputtext"/></td>
        </tr>
         <tr>
            <td>
                <br>
                <strong>Nombre</strong><font color="#FF0000">*</font>
                <br>
            </td>
            <td><input type="text" name="pais" class="form-control inputtext"/></td>
        </tr>     
        <tr>
            <td>
                <br>
                <strong>Ciudad</strong><font color="#FF0000">*</font>
                <br>
            </td>
            <td> <input type="tex" placeholder="Ejem Bogota" name="ciudad" class="form-control inputtext"/></td>
        </tr>   
                    </table>
                   
        <input type="submit" name="buscar" value="Buscar" class="btn btn-success">
                   <input type="submit"name="generar"value="Generar Reporte"class="btn btn-success">
               <br><br mofos>
                </form>
                <form action="exportarPDF.jsp" method="post">
                    <input type="submit" name="generar" value="Generar Reporte PDF" class="btn btn-success">
                </form>

            </center>
        
            
            <%

                HttpSession miSession = request.getSession(false);

                if (miSession.getAttribute("nombres") != null) {
                    ArrayList<listarPerDTO> person = (ArrayList<listarPerDTO>) miSession.getAttribute("nombres");

                    if (person.size() == 0) {
            %>

            <br>
            <br>
            <center>
            <div class="row text-right">
                <div class="col-md-6 alert alert-info"><h2 class="text-center">Lo sentimos, no hay resultados</h2></div>

            </div>  
         
            <%
            } else {
            %> 
            </center>
            <center>    

                <%
                    listarPerDTO per = new listarPerDTO();
                    FacadePersonas facadeP = new FacadePersonas();
                    ArrayList<listarPerDTO> perso = new ArrayList();
                    int numreg = facadeP.contarNumerosdeRegistros(null);
                    int numero = numreg / 5;
                    int pg = 0;
                    if (request.getParameter("pg") == null) {
                        pg = 1;
                    } else {
                        pg = Integer.valueOf(request.getParameter("pg"));
                    }
                    perso = (ArrayList<listarPerDTO>) facadeP.Paginacio2(pg, 5);

                %>

                <center>
                        <div class="col-md-6"><h2>Resultados de la búsqueda</h2></div>                         
                </center>
                <br>
                <table class="table table-bordered table-striped table-hover"> 
                    <thead>
                    <td>Nombres</td>
                    <td>apellidos</td>
                    <td>Correo Electronico</td>
                    <td>Ciudad</td>
                    <td>Nacionalidad</td>
                    <td>Idioma</td>
                    </thead>
                    <%                    
                    for (listarPerDTO nombre : person) {
                    %>

                    <tr>

                        <td><%=nombre.getNombres()%></td>
                        <td><%=nombre.getApellidos()%></td>
                        <td><%=nombre.getCorreoElectronico()%></td>
                        <td><%=nombre.getCiudad()%></td>
                        <td><%=nombre.getNacionalidad()%></td>
                        <td><%=nombre.getIdioma()%></td>
                    </tr>
                    <%
                        }
                    %>
                </table>


                <div class="pagination" id="">
                    <%
                        int adelanteA;
                        if (request.getParameter("pg") == null) {
                            adelanteA = 1;
                        } else {
                            adelanteA = Integer.parseInt(request.getParameter("pg"));
                        }

                    %> 
                    <a href="?pg=<%=adelanteA - 1%>">&laquo</a>

                    <%
                        for (int j = 0; j < numero + 1; j++) {
                    %>  
                    <a href="?pg=<%=j + 1%>"><%=j + 1%></a>
                    <%
                        }
                    %> 
                    <a href="?pg=<%=adelanteA + 1%>">&raquo</a>
                </div>

                <%
                        }
                    }
                %>



            </center>



         <div style="width:100%; background: #0C4391; height: 30px; margin-top:10px; padding-top:5px; border-radius:3px;color:#e2c60f; margin-bottom:1%; float:left; text-align: center;height:70px;color:white;">
        <span>Booking Routers &copy; 2015</span><br>
        Integrantes :<span class="glyphicon glyphicon-user" style="padding-top: 4px;"></span> Yilber Hernandez 
        <span class="glyphicon glyphicon-user" style="padding-top: 4px;"></span> Cristian Moreno 
        <span class="glyphicon glyphicon-user" style="padding-top: 4px;"></span> Sergio Stiven Urbina
        <span class="glyphicon glyphicon-user" style="padding-top: 4px;"></span> Andres Feipe Guerrero<br>
        <img src="imagenes/dddd.png"><a href="CreaRuta1.jsp" style=" color: #ffffff; text-decoration: none;"  >English</a> --  <img src="imagenes/original.jpg"><a href="CreaRuta.jsp" style=" color: #ffffff; text-decoration: none;" >Spanish</a>

</div>



    </body>
</html>
