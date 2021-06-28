<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報 詳細ページ</h2>

               <p>
               <c:choose>
               <c:when test="${report.approval == 0}">未承認</c:when>
               <c:when test="${report.approval == 1}">差し戻し</c:when>
               <c:otherwise>承認</c:otherwise>
               </c:choose>
               </p>

                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name }" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${report.content}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>コメント</th>
                            <td>
                                <pre><c:out value="${report.comment}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td><fmt:formatDate value="${report.created_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td><fmt:formatDate value="${report.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                    </tbody>
                </table>


                <form method="POST" action="<c:url value='/reports/read' />">
                <label for="read_flag">この日報を既読にする</label><br/>
                <c:if test="${sessionScope.login_employee.admin_flag == 1}">
                <select name="read_flag">
                <option value="0"<c:if test="${report.read_flag == 0}"> selected</c:if>>未読</option>
                <option value="2"<c:if test="${report.read_flag == 1}"> selected</c:if>>既読</option>
                </select>
                </c:if>
                <c:if test="${sessionScope.login_employee.id == report.employee.id && sessionScope.login_employee.admin_flag == 0}">
                <select name="read_flag">
                <option value="1"<c:if test="${report.read_flag == 1}"> selected</c:if>>未読</option>
                <option value="2"<c:if test="${report.read_flag == 0}"> selected</c:if>>既読</option>
                </select>
                </c:if>
                <br />
                <br />
                <input type="hidden" name="_token" value="${_token}" />
                <button type="submit">投稿</button>
                </form>

                <c:if test="${sessionScope.login_employee.id == report.employee.id || sessionScope.login_employee.admin_flag == 1}">
                <p><a href="<c:url value='/reports/edit?id=${report.id}'/>">この日報を編集する</a></p>
                </c:if>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value='/reports/index' />">一覧に戻る</a></p>
    </c:param>
</c:import>