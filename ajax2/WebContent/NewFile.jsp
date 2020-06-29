<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <div id="map" style="width:500px;height:400px;"></div>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2bc77ca67693e7633f95f1e279e4985"></script>
    <script>


        fetch('http://openapi.seoul.go.kr:8088/6363676c6962686335364b69517547/JSON/SdeWarnhydrantgt/1/5/').then(function (response) {
            console.log(response);
            if (response.status !== 200) {
                alert("서버와의 통신 실패!");
                return;
            } else {
                return response.json();
            }
        }).then(function (jsonData) {

            // 마커를 표시할 위치와 title 객체 배열입니다 
            var positions = [
                // {
                //     title: '카카오',
                //     latlng: new kakao.maps.LatLng(33.450705, 126.570677)
                // },
            ];

            for(var i=0; i<jsonData.SdeWarnhydrantgt.row.length;i++) {
            var lat = jsonData.SdeWarnhydrantgt.row[i].X;
            var lng = jsonData.SdeWarnhydrantgt.row[i].Y;
            console.log(lat);
            console.log(lng);

            var coords = new kakao.maps.Coords(lat * 2.5, lng * 2.5); // wtm * 2.5 필요
            var latlng = coords.toLatLng(); // 변환
            console.log(latlng.getLng());
            console.log(latlng.getLat());

            positions.push({title:jsonData.SdeWarnhydrantgt.row[i].NEWADDR, latlng:coords.toLatLng()});
                
            }

            console.log(positions);
            console.log(positions[0].latlng.ga);
   




            var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };

            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

            

            // 마커 이미지의 이미지 주소입니다
            var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

            for (var i = 0; i < positions.length; i++) {

                // 마커 이미지의 이미지 크기 입니다
                var imageSize = new kakao.maps.Size(24, 35);

                // 마커 이미지를 생성합니다    
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: positions[i].latlng, // 마커를 표시할 위치
                    title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                    image: markerImage // 마커 이미지 
                });
            }

        });





    </script>

</body>

</html>