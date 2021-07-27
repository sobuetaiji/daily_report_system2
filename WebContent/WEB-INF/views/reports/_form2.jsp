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
<label for="report_date">日付</label><br />
<input type="date" name="report_date" value="<fmt:formatDate value='${report.report_date}' pattern='yyyy-MM-dd' />" />
<br />
<br />
<label for="name">氏名</label><br />
<c:out value="${sessionScope.login_employee.name}" />
<br />
<br />
<label for="title">タイトル</label><br />
<input type="text" name="title" value="${report.title}" />
<br />
<br />
<label for="content">内容</label><br/>
<textarea name="content" rows="10" cols="50">${report.content}</textarea>
<br />
<br />
<c:choose>
<c:when test="${sessionScope.login_employee.admin_flag == 1}">
<label for="comment">コメント</label><br />
<textarea name="comment" rows="10" cols="50">${report.comment}</textarea>
<br />
<br />
<label for="approval"></label>
<select name="approval">
<option value="1"<c:if test="${report.approval == 0}"> selected</c:if>>差し戻し</option>
<option value="2"<c:if test="${report.approval == 1}"> selected</c:if>>承認</option>
</select>
<br />
<br />
</c:when>
<c:otherwise>
<label for="comment"></label>
<input type="hidden" name="comment" value="${report.comment}" />
<label for="approval"></label>
<c:choose>
<c:when test="${report.approval == 1}">
<input type="hidden" name="approval" value="3" />
</c:when>
<c:otherwise>
<input type="hidden" name="approval" value="${report.approval}" />
</c:otherwise>
</c:choose>
</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${sessionScope.login_employee.admin_flag == 0}">
<input type="hidden" name="read_flag" value="0" />
</c:when>
<c:otherwise>
<input type="hidden" name="read_flag" value="1" />
</c:otherwise>
</c:choose>
<input type="hidden" name="_token" value="${_token}" />
<button type="submit">投稿</button>