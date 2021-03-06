<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/jsp/header.jsp" %>
    <title>学习中心</title>
</head>
<body>
    <%@include file="/WEB-INF/jsp/nav.jsp" %>
    
    <div id="mainDiv" class="container" style="margin-top:35px;">
        <style>
            .panel-body a{
                cursor: pointer;
                display:block;
                margin-bottom4px;
            }
        </style>
        <div class="row">
            <div class="col-xs-6">
                <!-- 我的课程 -->
                <div class="panel panel-info" >
                    <div class="panel-heading"> 
                        <h3 class="panel-title">我的课程</h3> 
                    </div> 
                    <div class="panel-body">
                        <a href="<%=ctxPath %>/card/applyNext.do" target="_blank" style="color:red;margin-bottom: 20px;">申请新的学习卡 &gt;&gt;</a>
                        <c:if test="${not empty cardList }">
                            <a href="<%=ctxPath %>/card/latest.do" target="_blank" style="color:red;margin-bottom: 20px;">上次学到这里 &gt;&gt;</a>
                        </c:if>
                        <c:forEach items="${cardList }" var="card">
                            <a href="<%=ctxPath %>/card/detail.do?cardId=${card.id}" target="_blank" style="margin-bottom: 6px;">${card.name }学习卡</a>
                        </c:forEach>
                    </div> 
                </div>
            </div>
             
            <div class="col-xs-6">
                <!-- 问题和提问 -->
                <div class="panel panel-danger" >
                    <div class="panel-heading"> 
                        <h3 class="panel-title">问题和提问</h3> 
                    </div> 
                    <div class="panel-body">
                        <div> 
                            <a href="<%=ctxPath %>/question/ask.do" target="_blank" style="color:red;margin-bottom: 20px;">我要提问 &gt;&gt;</a>
                            <a href="<%=ctxPath %>/question/list.do" target="_blank" style="color:red;margin-bottom: 20px;">所有问题列表 &gt;&gt;</a>
                        </div>
                        
                        <div id="questionDiv" style="margin-top: 20px;">
                            <c:forEach items="${questionList }" var="question">
                                <a id="question${question.id }" href="<%=ctxPath%>/question/detail.do?questionId=${question.id }" target="_blank" onclick="$(this).remove()">您提问的或者参与的问题还未解决</a>
                            </c:forEach>
                        </div>
                    </div> 
                </div>                
            </div>
        </div>
        <div id="notifyAudio" style="display: none;"></div>
        <script type="text/javascript">

            //获取新通知信息
            function getNotifications(){
                $.post('<%=ctxPath%>/notification.do',{},function(ajaxResult){
                    if(ajaxResult.status=='success'){
                        var notifications = ajaxResult.data;
                        if(!notifications || notifications.length<1){
                        	return;
                        }
                        //播放提示音
                        $("#notifyAudio").html("<audio src='<%=ctxPath%>/audios/notify.mp3' autoplay='autoplay'></audio>");
                        for(var i=0;i<notifications.length;i++){
                            var questionId = notifications[i].questionId;
                            var content = notifications[i].content;
                            //删掉questionId相同的通知
                            $("#question"+questionId).remove();
                            //追加新通知
                            $("#questionDiv").append('<a class="blink" id="question'+questionId+'" href="<%=ctxPath%>/question/detail.do?questionId='+questionId+'" target="_blank" onclick="$(this).remove()">'+content+'</a>');
                        }
                    }
                },'json');
            }
            
            $(function(){
                getNotifications();
                
                //定时器，每隔10秒检查是否有新的通知
                setInterval(function(){
                    getNotifications();
                },10000);
                
                //通知消息闪烁
                var i=0;
                setInterval(function(){
                    $(".blink").css("color",(i%2==0)?'red':'blue');
                    i++;
                },500);
            });
        </script>
    </div>
    <%@include file="/WEB-INF/jsp/footer.jsp" %>
</body>
</html>