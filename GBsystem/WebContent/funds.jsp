<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="model.Fund"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="Views/bootstrap.min.css">
<script src="jquery-3.2.1.min.js"></script>

<script>
$(document).ready(function() {

	if ($("#alertSuccess").text().trim() == "") {

		$("#alertSuccess").hide();
	}
	$("#alertError").hide();

});

// SAVE ============================================
$(document).on("click", "#btnSave", function(event) {

	// Clear alerts---------------------
	$("#alertSuccess").text("");
	$("#alertSuccess").hide();
	$("#alertError").text("");
	$("#alertError").hide();

	// Form validation-------------------
	var status = validateFundForm();
	if (status != true) {
		$("#alertError").text(status);
		$("#alertError").show();
		return;
	}
	// If valid------------------------
	$("#formFund").submit();
});

//UPDATE==========================================
$(document).on("click",".btnUpdate",function(event) {
			$("#hidIdfundSave").val($(this).closest("tr").find('#hidIdfundUpdate').val());
			$("#projectID").val($(this).closest("tr").find('td:eq(0)').text());
			$("#reasercherID").val($(this).closest("tr").find('td:eq(1)').text());
			$("#clientID").val($(this).closest("tr").find('td:eq(2)').text());
			$("#fundAmount").val($(this).closest("tr").find('td:eq(3)').text());
			$("#status").val($(this).closest("tr").find('td:eq(4)').text());
		});

// CLIENT-MODEL================================================================
function validateFundForm() {
	
	// PROJECT ID
	if ($("#projectID").val().trim() == "") {
		return "Insert Project ID.";
	}
	
	// RESEARCHER ID
	if ($("#reasercherID").val().trim() == "") {
		return "Insert Reasercher ID.";
	}
	
	// CLIENT ID
	if ($("#clientID").val().trim() == "") {
		return "Insert Client ID.";
	}
	
	// AMOUNT-------------------------------
	if ($("#fundAmount").val().trim() == "") {
		return "Insert Fund Amount.";
	}
	// is numerical value
	var tmpAmount = $("#fundAmount").val().trim();
	if (!$.isNumeric(tmpAmount)) {
		return "Insert a numerical value for Fund Amount.";
	}
	// convert to decimal price
	$("#fundAmount").val(parseFloat(tmpAmount).toFixed(2));
	
	// STATUS------------------------
	if ($("#status").val().trim() == "") {
		return "Insert Fund Status.";
	}
	return true;
}
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-6">

				<h1 class="m-3">Student details</h1>

				<form id="formFund" name="formFund" method="post" action="funds.jsp">
					Project ID: <input id="projectID" name="projectID" type="text" class="form-control form-control-sm"> 
					<br> Researcher ID: 
					<input id="reasercherID" name="reasercherID" type="text" class="form-control form-control-sm"> 
					<br> Client ID:
					<input id="clientID" name="clientID" type="text" class="form-control form-control-sm"> 
					<br> Fund Amount: 
					<input id="fundAmount" name="fundAmount" type="text" class="form-control form-control-sm"> 
					<br> Status: 
					<input id="status" name="status" type="text" class="form-control form-control-sm"> 
					<br> 
					<input id="btnSave" name="btnSave" type="button" value="Save" class="btn btn-primary"> 
					<input type="hidden" id="hidIdfundSave" name="hidIdfundSave" value="">
				</form>

				<%
					//Save---------------------------------
				if (request.getParameter("projectID") != null) {
					Fund f = new Fund();
					String stsMsg = "";
					//Insert--------------------------
					if (request.getParameter("hidIdfundSave") == "") {
						stsMsg = f.addFund(request.getParameter("projectID"), request.getParameter("reasercherID"),
						request.getParameter("clientID"), request.getParameter("fundAmount"), request.getParameter("status"));
					} else
					//Update----------------------
					{
						stsMsg = f.updateFund(request.getParameter("hidIdfundSave"), request.getParameter("projectID"),
						request.getParameter("reasercherID"), request.getParameter("clientID"),
						request.getParameter("fundAmount"), request.getParameter("status"));
					}
					session.setAttribute("statusMsg", stsMsg);
				}
				//Delete-----------------------------
				if (request.getParameter("hidIdfundDelete") != null) {
					Fund f = new Fund();
					String stsMsg = f.deleteFund(request.getParameter("hidIdfundDelete"));
					session.setAttribute("statusMsg", stsMsg);
				}
			%>
			
			<div id="alertSuccess" class="alert alert-success">
				<%
					out.print(session.getAttribute("statusMsg"));
				%>
			
			</div>
			
			<div id="alertError" class="alert alert-danger"></div>
			<br>
				<%
					Fund f = new Fund();
					out.print(f.viewFunds());
				%>
			

			</div>
		</div>
	</div>

</body>
</html>