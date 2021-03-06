<%@ page import="edu.stanford.dlss.flipbook.PagesMetadataJSON" %>

<%
  String id = request.getParameter("id");
  String json = null;

  if (id != null && id.matches("\\w{11}")) {
    PagesMetadataJSON metadata = new PagesMetadataJSON(id);
    Boolean isStanfordOnly = metadata.isStanfordOnly();

    json = metadata.getJSON();

    if (isStanfordOnly) {
      String authURL = request.getRequestURL().toString();

      authURL = authURL.replace("http://", "https://");
      authURL = authURL.replace("/embed.jsp", "/auth/embed.jsp");
      response.sendRedirect(authURL + "?id=" + id);
    }
  } else {
    response.sendRedirect("id-invalid.jsp");
  }
%>

<html>
  <head>
    <title>Stanford University BookReader</title>
    <link rel="stylesheet" type="text/css" href="css/BookReader.css"/>
    <link rel="stylesheet" type="text/css" href="css/BookReaderDemo.css"/>
    <link rel="stylesheet" type="text/css" href="css/BookReaderEmbed.css"/>
  </head>

  <body>
    <div id="logo-sulair"></div>
    <div id="BookReader">
      <div class="initMessage">
	  	Loading book ...
	  </div>
      <noscript>
        <p>
        The BookReader requires JavaScript to be enabled. Please check that your browser supports
        JavaScript and that it is enabled in the browser settings.
        </p>
      </noscript>
    </div>

    <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.8.5.custom.min.js"></script>

    <script type="text/javascript" src="js/dragscrollable.js"></script>
    <script type="text/javascript" src="js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.ipad.js"></script>
    <script type="text/javascript" src="js/jquery.bt.min.js"></script>

    <script type="text/javascript">
      <% if (json.equalsIgnoreCase("Invalid JSON")) { %>
        var flipbookJSON = "<%= json %>";
      <% } else { %>
        var flipbookJSON = <%= json %>;
      <% } %>
    </script>

    <script type="text/javascript" src="js/BookReader.js"></script>
    <script type="text/javascript" src="js/BookReaderSU.js"></script>
    <script type="text/javascript" src="js/BookReaderJSSimple.js"></script>

  </body>
</html>
