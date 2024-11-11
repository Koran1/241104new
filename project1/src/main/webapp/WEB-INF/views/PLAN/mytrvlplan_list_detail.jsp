<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyTravelList - 여행계획보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="resources/css/admin.css" rel="stylesheet"/>
<style type="text/css">
	
	#main-content {
	display: flex;
	flex-direction: row;
	width: 100%;
	height: 600px;
}

.travelplans {
	display: flex;
	flex-direction: column;
	width: 40%;
	border: 1px solid black;
	align-items: center;
}

.travelplan {
	width: 80%;
	height: 15%;
	margin-top: 20px;
	border: 1px solid black;
	display: flex;
	justify-content: space-around;
	align-items: center;
}

.travelplan img {
	height: 50px;
	width: 50px;
}

#map-content {
	width: 100%;
	border: 1px solid black;
}

#map {
	width: 100%;
	height: 100%;
}
#container{
	margin: 0;
	padding-top: 100px;
	width: 100%;
	height: 95vh;
}
</style>
</head>
<body>	

	<jsp:include page="../MAIN/header.jsp" />

    <div id="container">
        <div id="button_container">
            <button onclick="location.href='/mytrvlplan'">나의 관심지 관리</button>
            <button onclick="location.href='/mytrvlplan_create'">여행 계획 짜기</button>
            <button style="background-color:#008165; color: white; font-weight: bold;" onclick="location.href='/mytrvlplan_list'">여행 계획 관리</button>
        </div>

		<div id="main_container">
			
			<div id="top-bar">
				<h2>${tplvo.trvlPlanDate} ${list[0].touritEtc01}</h2>
				<h1>${tplvo.trvlPlanSubject}</h1>
			</div>
			
			<!-- Main Content -->
			<div id="main-content">
				<div class="travelplans">
					<c:forEach var="k" items="${list_detail}">
						<div class="travelplan"
						data-category="${k.region}"
						data-lat="${k.latitude}" data-lng="${k.longitude}"
						data-index="${k.travelIdx}" data-name="${k.trrsrtNm}">
						<p>${k.trrsrtNm}</p>
						<a href="/travelDetail_go?travelIdx=${k.travelIdx}"><img src="${k.placeImg01}" alt="img"></a>
						<div class="dist_time"> - km<br> - 분</div>
						</div>
					</c:forEach>
				</div>

				<div id="map-content">
					<div id="map"></div>
				</div>
			</div>

			<!-- Bottom Bar -->
			<div id="bottom-bar">
				<button onclick="location.href = '/mytrvlplan_update?trvlPlanIdx=${tplvo.trvlPlanIdx}'">수정하기</button>
				<button onclick="chkDelete(${tplvo.trvlPlanIdx})" style="background-color: #FA0000; color: white;">삭제</button>
			</div>
		</div>
	</div>
	<jsp:include page="../MAIN/footer.jsp" />
<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ab528374e287b067bf7ce3808786127"></script>
	<script>
        let map;
        let isMapInit = false;
		let isCreateOK = false;
		
        function initMap(lat, lng) {
            mapOption = {
                center: new kakao.maps.LatLng(lat, lng),
                level: 6
            };
            map = new kakao.maps.Map(document.getElementById('map'), mapOption);
        }
		
        let markers = [];
        let infowindows = [];
        
        function addMarker(lat, lng, iwcontent) {
            let marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(lat, lng),
                map: map
            });
            
        	let infowindow = new kakao.maps.InfoWindow({
                position : new kakao.maps.LatLng(lat, lng), 
                content : iwcontent,
            });
        	infowindow.open(map, marker);
            
        	markers.push({ marker, lat, lng });
            infowindows.push({ infowindow, lat, lng });
        }
        
		function getRoadLine2() {
				let linePath = [];
				let positions = [];
				let idx_container = [];
				
				document.querySelectorAll('.travelplan').forEach(item =>{
					const data_idx = item.getAttribute('data-index');
				    idx_container.push(data_idx);
					const data_name = item.getAttribute('data-name');
		            const lng = parseFloat(item.getAttribute('data-lng'));
					const lat = parseFloat(item.getAttribute('data-lat'));
					positions.push(lng);
				    positions.push(lat);
				    
				    if (!isMapInit) {
				    	initMap(lat, lng);
	                    isMapInit = true;
	                }
				    let iwcontent = '<p>'+data_name+'</p>'
	                addMarker(lat, lng, iwcontent);
				    
				})
	            map.setCenter(new kakao.maps.LatLng(markers[0].lat, markers[0].lng));
	            
				$.ajax({	
					url : "/kakaoRoadLine2",
					method : "get",
					data : {positions : positions, idx_container : idx_container},
					dataType : "json",
					success : function(data) {
						console.log(data);
		                const dist_time = document.querySelectorAll(".dist_time");
		                
		                let i = 1;
						data.forEach(plan => {
							dist_time[i].innerHTML = '<p>'+Math.ceil(plan.routes[0].sections[0].distance/10)/100+'km</p><p>  '
							+Math.ceil(plan.routes[0].sections[0].duration/60)+' 분</p>';
							i++;
						})
						
						let zidx = 5;
			            // Drawing part
						data.forEach(route => {
							linePath = [];
							route.routes[0].sections[0].roads.forEach(item => {
								  item.vertexes.forEach((vertex, index) => {
									if (index % 2 === 0) {
										linePath.push(new kakao.maps.LatLng(item.vertexes[index + 1], item.vertexes[index]));
									}
								});
							});
							
							let polyline = new kakao.maps.Polyline({
								map : map,
								endArrow : true,
								path: linePath,
								strokeWeight: 4,
								strokeColor: '#0000FF',
								strokeOpacity: 0.8,
								strokeStyle: 'solid',
								zIndex: zidx
							}); 
							
							kakao.maps.event.addListener(polyline, 'mouseover', function(mouseEvent) { 
								polyline.setOptions({
									strokeWeight: 6,
									strokeColor: '#FF0000',
									strokeOpacity: 1,
									strokeStyle: 'solid'        
								}); 
							});
							
							kakao.maps.event.addListener(polyline, 'mouseout', function(mouseEvent) {  
								polyline.setOptions({
									strokeWeight: 4,
									strokeColor: '#0000FF',
									strokeOpacity: 0.8,
									strokeStyle: 'solid'      
								}); 	
							});
							
							zidx--;
						})
						
					}, 
					error : function() {
						alert("읽기 실패!");
					} 
				})
		}
		getRoadLine2();
		function chkDelete(trvlPlanIdx) {
			if(confirm("정말 삭제하시겠습니까? (복구가 불가능합니다)")){
				location.href = '/mytrvlplan_delete?trvlPlanIdx='+trvlPlanIdx;
			}
			
		}
</script>

</body>
</html>