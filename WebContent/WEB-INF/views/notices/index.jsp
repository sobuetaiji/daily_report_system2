<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush !=null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>日報通知 一覧</h2>
        <c:choose>
        <c:when test="${sessionScope.login_employee.admin_flag == 1}">
        <table id="member_list">
            <tbody>
                <tr>
                    <th class="member_approval">承認</th>
                    <th class="member_name">氏名</th>
                    <th class="member_date">日付</th>
                    <th class="member_title">タイトル</th>
                    <th class="member_action">操作</th>
                    <th class="member_read">既読</th>
                </tr>
                <c:forEach var="member" items="${members}" varStatus="status">
                    <tr class="row${status.count % 2}">
                    <td class="member_approval">
                    <c:choose>
                    <c:when test="${member.approval == 0}">未承認</c:when>
                    <c:when test="${member.approval == 1}">差し戻し</c:when>
                    <c:otherwise>承認</c:otherwise>
                    </c:choose>
                    </td>
                    <td class="member_name"><c:out value="${member.employee.name}" /></td>
                    <td class="member_date"><fmt:formatDate value='${member.report_date}' pattern='yyy-MM-dd' /></td>
                    <td class="member_title">${notice.title}</td>
                    <td class="member_action"><a href="<c:url value='/reports/show?id=${member.id}' />">詳細を見る</a></td>
                    <td class="member_read">
                        <c:choose>
                        <c:when test="${member.read_flag == 0}">未読</c:when>
                        <c:otherwise>既読</c:otherwise>
                        </c:choose>
                    </td>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            (全 ${members_count} 件)<br />
            <c:forEach var="i" begin="1" end="${((members_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        </c:when>
        <c:otherwise>
            <table id="read_list">
            <tbody>
                <tr>
                    <th class="read_approval">承認</th>
                    <th class="read_name">氏名</th>
                    <th class="read_date">日付</th>
                    <th class="read_title">タイトル</th>
                    <th class="read_action">操作</th>
                    <th class="read_read">既読</th>
                </tr>
                <c:forEach var="read" items="${reads}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="read_approval">
                        <c:choose>
                        <c:when test="${read.approval == 0}">未承認</c:when>
                        <c:when test="${read.approval == 1}">差し戻し</c:when>
                        <c:otherwise>承認</c:otherwise>
                        </c:choose>
                        </td>
                        <td class="read_name"><c:out value="${read.employee.name}" /></td>
                        <td class="read_date"><fmt:formatDate value='${read.report_date}' pattern='yyy-MM-dd' /></td>
                        <td class="read_title">${report.title}</td>
                        <td class="read_action"><a href="<c:url value='/reports/show?id=${read.id}' />">詳細を見る</a></td>
                        <td>
                        <c:choose>
                        <c:when test="${read.read_flag == 1}">未読</c:when>
                        <c:otherwise>既読</c:otherwise>
                        </c:choose>
                    </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            (全 ${reads_count} 件)<br />
            <c:forEach var="i" begin="1" end="${((reads_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        </c:otherwise>
        </c:choose>
    </c:param>
</c:import>