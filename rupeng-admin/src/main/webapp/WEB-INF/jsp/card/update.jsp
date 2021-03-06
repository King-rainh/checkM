<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/jsp/header.jsp" %>
<title>修改学习卡</title>
</head>
<body>
<div class="pd-20">
    <form onsubmit="ajaxSubmitForm(this,true)" action="<%=ctxPath %>/card/update.do" class="form form-horizontal">
        <input type="hidden" name="id" value="${card.id }" />
        <div class="row cl">
            <label class="form-label col-2">学习卡名称</label>
            <div class="formControls col-5">
                <input type="text" class="input-text"  name="name" value="${card.name }"/>
            </div>
            <div class="col-5"></div>
        </div>
        
        <div class="row cl">
            <label class="form-label col-2">所属学科</label>
            <div class="formControls col-5">
                <c:forEach items="${subjectList }" var="subject">
                    <input id="subject${subject.id }" type="checkbox" name="subjectIds" value="${subject.id }" 
                        <c:forEach items="${cardSubjectList }" var="cardSubject">
                            <c:if test="${cardSubject.subjectId==subject.id }">checked="checked"</c:if>
                        </c:forEach>
                    /><label for="subject${subject.id }" style="margin-right: 10px;">${subject.name }</label>
                </c:forEach>
            </div>
            <div class="col-5"></div>
        </div>
        
        <div class="row cl">
            <label class="form-label col-2">描述</label>
            <div class="formControls col-5">
            <textarea name="description" class="textarea" >${card.description }</textarea>
            </div>
            <div class="col-5"></div>
        </div>
        
        <div class="row cl">
            <label class="form-label col-2">课件下载地址</label>
            <div class="formControls col-5">
                <input type="text" class="input-text"  name="courseware" value="${card.courseware }" />
            </div>
            <div class="col-5"></div>
        </div>

        <div class="row cl">
            <div class="col-9 col-offset-2">
                <input class="btn btn-primary radius" type="submit" value="修改" />
                <input class="btn btn-default radius" type="button" value="关闭" onclick="parent.location.reload()" style="margin-left: 30px;" />
            </div>
        </div>
    </form>
</div>
</body>
</html>