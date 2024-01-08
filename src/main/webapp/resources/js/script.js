window.onload = function () {
  var main_view = new Swiper("#main_view", {
    wrapperClass: "slider", //슬라이드요소를 감싸는 요소의 클래스
    slideClass: "view", // 슬라이드요소들의 공통 클래스
    spaceBetween: 10, //슬라이드 사이간격
    speed: 800,
    autoplay: {
      delay: 4000,
      disableOnInteraction: false, // 상호 작용후 다시 자동재생 실행.
    },
    pagination: {
      //페이지버튼 활성화
      el: ".pager", // 페이지구성 영역지정
      clickable: true,
    },
  });

  var press = new Swiper("#press .inner", {
    wrapperClass: "slider",
    slideClass: "item",
    slidesPerView: 5,
    spaceBetween: 30,
    pagination: {
      el: ".pager",
      clickable: true,
      bulletActiveClass: "active", //활성된 영역에 추가되는 클래스
    },
  });

  let open_search = document.querySelector(".open_search");
  let search = document.getElementById("search");
  let close_search = document.querySelector(".close_search");
  open_search.addEventListener("click", function () {
    search.classList.add("show");
  });
  close_search.addEventListener("click", function () {
    search.classList.remove("show");
  });

  document.documentElement.addEventListener("keydown", function (e) {
    //document.documentElement == 문서의 루트요소 <html>
    let state = search.classList.contains("show");
    // let esc = e.keyCode; // 웹표준에는 맞지 않다.
    let keyName = e.key;
    // console.log("키보드코드 :" + esc + ", 키보드키:" + keyName + ", 검색");
    if (state && keyName == "Escape") {
      search.classList.remove("show");
    }
  });

  /*
  요소.classList.add();
    : 지정한 값의 클래스를 추가한다.
  요소.classList.remove();
    : 지정한 값의 클래스를 제거한다.
  요소.classList.toggle();
    : 지정한 값의 클래스가 있으면 제거하고, 없으면 추가한다.
  요소.classList.item();
    : 지정한 순번의 클래스를 반환한다.
  요소.classList.contain(문자);
    : 지정한 클래스가 있는 지 확인한다.(true/false);
  요소.classList.replace(oldClass,newClass);
    : 기존의 클래스를 새로운 클래스로 교체한다.
  */
};

window.addEventListener("scroll", function () {
  let scroll = document.documentElement.scrollTop;
  let header = document.querySelector("header");
  if (scroll > 100) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
