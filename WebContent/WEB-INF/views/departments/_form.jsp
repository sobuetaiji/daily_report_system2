<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${errors !=null}">
    <div id="flush_error">
        入力内容にエラーがあります。<br />
        <c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" />
            <br />
        </c:forEach>
    </div>
</c:if>
<label for="department_date">日付</label><br />
<input type="date" name="department_date" value="<fmt:formatDate value='${department.department_date}' pattern='yyyy-MM-dd' />" />
<br />
<br />
<label for="name">部署名</label><br />
<input type="text" name="name" value="${department.name}" />
<br />
<br />
<input type="hidden" name="_token" value="${_token}" />
<button type="submit">投稿</button>