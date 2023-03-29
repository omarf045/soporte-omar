<%-- 
    Document   : index
    Created on : 11 abr. 2022, 00:45:30
    Author     : Omar Pulido
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"></script>

    </head>
    <body>
        <div>
            <div class="m-12">
                <form>
                    <div class="space-y-12">
                        <div class="border-b border-gray-900/10 pb-12">
                            <h2 class="text-base font-semibold leading-7 text-gray-900">Nuevo caso</h2>
                            <!--<p class="mt-1 text-sm leading-6 text-gray-600">This information will be displayed publicly so be careful what you share.</p>-->

                            <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">

                                <div class="sm:col-span-4">
                                    <label for="name" class="block text-sm font-medium leading-6 text-gray-900">Nombre</label>
                                    <div class="mt-2">
                                        <div class="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 sm:max-w-md">
                                            <input type="text" name="name" id="name" autocomplete="name" class="ml-1 block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" placeholder="Fallo en modulo de deteccion">
                                        </div>
                                    </div>
                                </div>

                                <div class="sm:col-span-4">
                                    <label for="user" class="block text-sm font-medium leading-6 text-gray-900">Usuario</label>
                                    <div class="mt-2">
                                        <div class="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 sm:max-w-md">
                                            <span class="flex select-none items-center pl-3 text-gray-500 sm:text-sm">workcation.com/</span>
                                            <input type="text" name="user" id="user" autocomplete="user" class="-ml-1 block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6" placeholder="0">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-span-full">
                                    <label for="about" class="block text-sm font-medium leading-6 text-gray-900">Descripcion</label>
                                    <div class="mt-2">
                                        <textarea id="about" name="about" rows="3" class="block w-full rounded-md border-0 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:py-1.5 sm:text-sm sm:leading-6"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-6 flex items-center justify-end gap-x-6">
                        <button type="button" class="text-sm font-semibold leading-6 text-gray-900">Cancel</button>
                        <button type="submit" class="rounded-md bg-indigo-600 py-2 px-3 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <div>

            <h2 class="max-w-6xl mx-auto mt-8 px-4 text-lg leading-6 font-medium text-gray-900 sm:px-6 lg:px-8">Recent activity</h2>

            <!-- Activity table (small breakpoint and up) -->
            <div class="hidden sm:block">
                <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex flex-col mt-2">
                        <div class="align-middle min-w-full overflow-x-auto shadow overflow-hidden sm:rounded-lg">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead>
                                    <tr>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Nombre</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Usuario</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Area</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Asignado a</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Creado</th>
                                        <th class="px-6 py-3 bg-gray-50 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Ultima actualizacion</th>
                                    </tr>
                                </thead>

                                <tbody class="bg-white divide-y divide-gray-200">

                                    <!-- Database connection -->
                                    <%
                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            Connection connection = null;
                                            Statement statement = null;
                                            ResultSet rs = null;
                                            String connectionURL = "jdbc:mysql://localhost:3306/elet", USER = "root", PWD = "toor";

                                            connection = DriverManager.getConnection(connectionURL, USER, PWD);
                                            statement = connection.createStatement();
                                            String SQLQuery = "SELECT c.id_case, c.case_name, u.user_name as user_username,c.case_area, u2.user_name as admin_username, c.case_status, c.case_creation_date, c.case_last_update_date FROM tbl_cases c INNER JOIN tbl_users u ON c.usr_id = u.id_user LEFT JOIN tbl_case_admin ca ON c.id_case = ca.case_id LEFT JOIN tbl_users u2 ON ca.admin_id = u2.id_user;";
                                            rs = statement.executeQuery(SQLQuery);

                                            while (rs.next()) {
                                                int id_case = rs.getInt("id_case");
                                                String case_name = rs.getString("case_name");
                                                String user_username = rs.getString("user_username");
                                                String case_area = rs.getString("case_area");
                                                String admin_username = rs.getString("admin_username");
                                                String case_status = rs.getString("case_status");
                                                String case_creation_date = rs.getString("case_creation_date");
                                                String case_last_update_date = rs.getString("case_last_update_date");
                                                if (case_last_update_date == null)  case_last_update_date = "";
                                                if (admin_username == null)  admin_username = "";                                              
                                    %>


                                    <tr class="bg-white">
                                        <!-- id -->
                                        <td class="px-6 py-4 text-right whitespace-nowrap text-sm text-gray-500">
                                            <span class="text-gray-900 font-medium"><%=id_case%></span>
                                        </td>
                                        <!-- nombre -->
                                        <td class="max-w-0 w-full px-6 py-4 text-center whitespace-nowrap text-sm text-gray-900">
                                            <div class="flex">
                                                <a href="#" class="group inline-flex space-x-2 truncate text-sm">
                                                    <!-- Heroicon name: solid/cash -->
                                                    <svg class="flex-shrink-0 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                                    <path fill-rule="evenodd" d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd" />
                                                    </svg>
                                                    <p class="text-gray-500 truncate group-hover:text-gray-900"><%=case_name%></p>
                                                </a>
                                            </div>
                                        </td>
                                        <!-- usuario -->
                                        <td class="px-6 py-4 text-center whitespace-nowrap text-sm text-gray-500">
                                            <span class="text-gray-900 font-medium"><%=user_username%></span>
                                        </td>
                                        <!-- area -->
                                        <td class="px-6 py-4 text-center whitespace-nowrap text-sm text-gray-500">
                                            <span><%=case_area%></span>
                                        </td>
                                        <!-- asignado a -->
                                        <td class="px-6 py-4 text-center whitespace-nowrap text-sm text-gray-500">
                                            <span class="text-gray-900 font-medium"><%=admin_username%></span>
                                        </td>
                                        <!-- status -->
                                        <td class="hidden px-6 py-4 whitespace-nowrap text-sm text-gray-500 md:block">
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 capitalize"> <%=case_status%> </span>
                                        </td>
                                        <!-- fecha de creacion -->
                                        <td class="px-6 py-4 text-center whitespace-nowrap text-sm text-gray-500">
                                            <time datetime="2020-07-11"><%=case_creation_date%></time>
                                        </td>
                                        <!-- fecha ultima actualizacion -->
                                        <td class="px-6 py-4 text-center whitespace-nowrap text-sm text-gray-500">
                                            <time datetime="2020-07-11"><%=case_last_update_date%></time>
                                        </td>
                                    </tr>


                                    <%
                                            }

                                            statement.close();
                                            connection.close();
                                        } catch (SQLException e) {
                                            out.println("SQLException caught: " + e.getMessage());
                                        }
                                    %>
                                    <!-- More transactions... -->
                                </tbody>
                            </table>

                            <!-- Pagination -->
                            <!--<nav class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6" aria-label="Pagination">
                                <div class="hidden sm:block">
                                    <p class="text-sm text-gray-700">
                                        Showing
                                        <span class="font-medium">1</span>
                                        to
                                        <span class="font-medium">10</span>
                                        of
                                        <span class="font-medium">20</span>
                                        results
                                    </p>
                                </div>
                                <div class="flex-1 flex justify-between sm:justify-end">
                                    <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"> Previous </a>
                                    <a href="#" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"> Next </a>
                                </div>
                            </nav>
                            -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
