<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mire woof</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- css common Area 헤더 푸터에 쓸 css 경로-->
<%@ include file="/WEB-INF/views/common/style.jsp"%>
<!-- script common Area 헤더 푸터에 쓸 script 경로-->
<%@ include file="/WEB-INF/views/common/script.jsp"%>
<!-- css local Area 각 개별페이지 css 경로는 여기다가 쓸 것-->
<%-- <%@ include file="" %> --%>
<!-- script local Area  각 개별페이지 script 경로는 여기다가 쓸 것 -->
<%-- <%@ include file="" %> --%>
<script>
	$(document).ready(function() {
		var formObj = $("#review");
		$("#btnRegister").on("click", function() {
			formObj.attr("action", "/review/insertPetReview");
			formObj.attr("method", "post");
			formObj.submit();
		});
		$("#btnList").on("click", function() {
			self.location = "/review/getReviewList";
		});
	});
</script>
<style>

textarea {
  width: 100%;
  height: 200px;
}
</style>
</head>
<body>
	<!-- Header Area -->
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<!-- Menu Area -->
	<%@ include file="/WEB-INF/views/common/mainMenu.jsp"%>
	<!-- subMenu Area -->
	<!-- 자기가 만든 페이지그룹에 해당하는 서브메뉴만 남길것 -->
	<main class="pt-2">
		<!-- ====================Content Area : <main> 과 </maim> 사이에 콘첸츠 작성 /======================================================== -->
		<div align="center">
			<section>
				<h5>리뷰 등록</h5>
				<div class="card" style="width: 20rem;">
					<div class="card-body">
						<p class="card-text">
							<form:form modelAttribute="review" action="insertPetReview"
								method="post" enctype="multipart/form-data">
								<br>
				제목<form:input path="reviewTitle" />
								<br>
								<br>
				내용<form:textarea path="reviewDesc" />
								<br>
								<br>
				작성자<form:input path="userName" readonly="true"/>
								<br>
				사진<input type="file" name="pictures" path="reviewPic" />
							</form:form>
						</p>
						<div>
							<button type="submit" id="btnRegister">Register</button>
							<button type="button" id="btnList">List</button>
						</div>
					</div>
				</div>
			</section>
		</div>
	</main>
	<!-- Footer Area -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>