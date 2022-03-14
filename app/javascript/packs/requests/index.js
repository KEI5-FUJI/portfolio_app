$(function() {
  $('.currentLocation').on('click', function(){
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(successGetposition, failGetPosition);}
    else
      {message = "ご使用中のブラウザは現在地検索に対応されておりません。";
       Alert.set('warning', message);}
      })
});

function successGetposition(position){
  window.location.href = "/requests?latitude=#{position.coords.latitude}&longitude=#{position.coords.longitude}"
}
     
function failGetPosition(error){
  switch(error.code) {
    case 1 :
      message = '位置情報の提供を許可してください。';
    case 2 :
      message = '位置情報の取得に失敗しました。';
    Alert.set('warning', message);}
}
