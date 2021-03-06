<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
	<head>
		<meta charset="UTF-8">
		<title>创建用户</title>
		<link href="../css/index.css" rel="stylesheet">
		<link   rel= "shortcut   icon "   href= "../img/favicon.ico ">
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	</head>
	<body>	
		<%@ include file="common/commonHT.jsp"%>
	    <div class="center">
	     <form method="post" action="addsave.do">
	    		<div class="useradd">
	    			<input type="hidden" name="orgUnit" value="${orgUnit}">
	    			<input type="hidden" name="customerId" value="${customerId}">
    				<ul class="other_text">
		    			<li><span>用户名</span><input type="text" maxlength="25" name="loginName" value="" onkeyup="this.value=this.value.replace(/[^\w_]/g,'');"/></li>
		    			<li><span>手机号</span><input type="text" maxlength="11" name="mobile"/></li>
		    			<li><span>姓&nbsp;名</span><input type="text" maxlength="10" name="commonName"/></li>
		    			<li><span>密&nbsp;码</span><input type="password" maxlength="20" name="password"/></li>
		    			<li><span>确认密码</span><input type="password" maxlength="20" name="password"/></li>
		    			<li><span>状态</span><label class="status"><input type="checkbox" name="status" value="1" checked><i>•</i></label></li>
		    		</ul>
		    		<div class="clear"></div>
	    		</div>
    			<div class="useradd">
    				<div>柜台</div>
    				<ul class="counter_text">
    				<c:forEach items="${counters}" var="c" varStatus="vs">
    					<li>	
			    				<label for="${c.counterId }"><input  type="checkbox" name="counterId" id="${c.counterId }" value="${c.counterId}"><i>✓</i>
		    					${c.counterName}</label>
		    			</li>
		    		</c:forEach>
		    		<div class="clear"></div>
    				</ul>
    				<div>角色</div>
    				<ul class="role_text">
    					<c:forEach items="${roles}" var="r" varStatus="vs">
    					<li>
	    					<label for="${r.rid }"><input type="checkbox" name="rid" id="${r.rid }" value="${r.rid}"><i>✓</i>
	    					${r.commonName}</label>
		    			</li>
		    			</c:forEach>
		    			<div class="clear"></div>
    				</ul>
    			</div>
    			<div class="clear"></div>
	    		<div class="user_sure">
	    			<input type="button" id="logout" value="取&nbsp;消" class="bg-green" />
	    			<input type="submit" value="确&nbsp;定"  class="bg-green add_button"/>
	    		</div>
	    		</form>
		</div>
		<%@ include file="common/commonF.jsp"%>	
	</body>
	<script src="../js/jquery.js"></script>
	<script src="../js/index.js"></script>
	<script>
		$(document).ready(function(){
			if($(".status input[name='status']").val()==0){
				$(".status").css({"background":"#ccc","text-align":"left"});
			}else{
				$(".status").css({"background":"#6dbb44","text-align":"right"});
			};
			$(".status input[name='status']").click(function(){
				if($(this).val()==0){
					$(this).val(1);
					$(this).attr("checked",true);
					$(".status").css({"background":"#6dbb44","text-align":"right"});
				}else{
					$(this).val(0);
					$(this).attr("checked",false);
					$(".status").css({"background":"#ccc","text-align":"left"});
				}
			});
			$('.translate').click(function(){
			    var s=$(this).parent().find('input').attr("disabled",false);				
			})
			$('select[name="orgId"]').on('change', function() {
				var orgId = $(this).val();
				var src="../user/cascade"
				var li=$('input[name="rid"]').parent();
				if(orgId!=""&&orgId!=null){
					$.ajax({
						type:"post",
						url:src+".do",
						data:{orgId:orgId},
						dataType: "json",
						async:true,
						success: function(data) {
							li.empty();
							li.append("<p>角色</p>");
							$.each(data,function(index, value){
								if(index>0&&index%2==0){
									li.append("<br/>");
								}
								var htmlcheckbox="<input type='checkbox' name='rid' id='"+value.rid+"' value='"+value.rid+"'>"
											+"<label for='"+value.rid+"'>"+value.commonName+"</label>";
								li.append(htmlcheckbox);
							}); 
						}
					});
				}
			});
			
		})
		$('#create').click(function(){
			window.location.href='../user/create.do';
		});
		
	 	$('#logout').click(function(){
			window.location.href='../user/setting.do';
		});
	 	$(".add_button").click(function(){
	 		var loginName = $("input[name='loginName']").val();
	 		var mobile = $("input[name='mobile']").val();
	 		var commonName = $("input[name='commonName']").val();
	 		var password = $("input[name='password']").val();
	 		var counterId = $(".counter_text").find("input[type='checkbox']:checked");
	 		var rid = $(".role_text").find("input[type='checkbox']:checked");
	 		if(loginName==""||loginName==null){
	 			$("input[name='loginName']").focus();
	 			alert("姓名不能为空");
	 			return false;
	 		}
	 		if(mobile==""||mobile==null){
	 			$("input[name='mobile']").focus();
	 			alert("手机号码不能为空");
	 			return false;
	 		}
	 		if(commonName==""||commonName==null){
	 			$("input[name='commonName']").focus();
	 			alert("姓名不能为空");
	 			return false;
	 		}
	 		if(password==""||password==null){
	 			$("input[name='password']").focus();
	 			alert("密码不能为空");
	 			return false;
	 		}
	 		if(counterId.length==0){
	 			alert("请 选择【柜台】 ！");
	 			return false;
	 		}
	 		if(rid.length==0){
	 			alert("请 选择【权限 】！");
	 			return false;
	 		}
	 		return true;
	 	});
	</script>
</html>
