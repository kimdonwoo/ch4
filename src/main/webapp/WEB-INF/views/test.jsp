<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  <title>Title</title>
  <style>
    * {
      border : 0;
      padding : 0;
    }

    ul {
      border:  1px solid rgb(235,236,239);
      border-bottom : 0;
    }

    li {
      background-color: #f9f9fa;
      list-style-type: none;
      border-bottom : 1px solid rgb(235,236,239);
      padding : 18px 18px 0 18px;
    }

    #commentList {
      width : 50%;
      margin : auto;
    }

    .comment-content {
      overflow-wrap: break-word;
    }

    .comment-bottom {
      font-size:9pt;
      color : rgb(97,97,97);
      padding: 8px 0 8px 0;
    }

    .comment-bottom > a {
      color : rgb(97,97,97);
      text-decoration: none;
      margin : 0 6px 0 0;
    }

    .comment-area {
      padding : 0 0 0 46px;
    }

    .commenter {
      font-size:12pt;
      font-weight:bold;
    }

    .commenter-writebox {
      padding : 15px 20px 20px 20px;
    }

    .comment-img {
      font-size:36px;
      position: absolute;
    }

    .comment-item {
      position:relative;
    }

    .up_date {
      margin : 0 8px 0 0;
    }

    #comment-writebox {
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
    }

    textarea {
      display: block;
      width: 100%;
      min-height: 17px;
      padding: 0 20px;
      border: 0;
      outline: 0;
      font-size: 13px;
      resize: none;
      box-sizing: border-box;
      background: transparent;
      overflow-wrap: break-word;
      overflow-x: hidden;
      overflow-y: auto;
    }

    .comment-writebox-bottom {
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    .btn {
      font-size:10pt;
      color : black;
      background-color: #eff0f2;
      text-decoration: none;
      padding : 9px 10px 9px 10px;
      border-radius: 5px;
      float : right;
    }

    #btn-write-comment, #btn-write-reply {
      color : #009f47;
      background-color: #e0f8eb;
    }

    #btn-cancel-reply {
      background-color: #eff0f2;
      margin-right : 10px;
    }

    #btn-write-modify {
      color : #009f47;
      background-color: #e0f8eb;
    }

    #btn-cancel-modify {
      margin-right : 10px;
    }

    #reply-writebox {
      display : none;
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
      margin : 10px;
    }

    #reply-writebox-bottom {
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    #modify-writebox {
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
      margin : 10px;
    }

    #modify-writebox-bottom {
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    /* The Modal (background) */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 100px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
    }

    /* The Close Button */
    .close {
      color: #aaaaaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: #000;
      text-decoration: none;
      cursor: pointer;
    }



    .paging {
      color: black;
      width: 100%;
      text-align: center;
    }

    .page {
      color: black;
      text-decoration: none;
      padding: 6px;
      margin-right: 10px;
    }

    .paging-active {
      background-color: rgb(216, 216, 216);
      border-radius: 5px;
      color: rgb(24, 24, 24);
    }

    .paging-container {
      width:100%;
      height: 70px;
      margin-top: 50px;
      margin : auto;
    }
  </style>
</head>
<body>
<%--<button id="sendBtn" type="button">SEND</button>--%>
<%--<button id="modBtn" type="button">수정</button>--%>

<div id="commentList">
    <h2>댓글 기능 구현</h2>
    <div id="comment-item">

    </div>
    <div id="comment-writebox">
      <div class="commenter commenter-writebox">${id}</div>
      <div class="comment-writebox-content">
        <textarea name="comment" id="" cols="20" rows="3" placeholder="댓글을 남겨보세요"></textarea>
      </div>
      <div class="comment-writebox-bottom">
        <div class="register-box">
          <button type="button" class="btn" id="btn-write-comment">등록</button>
        </div>
      </div>
    </div>
</div>

<%--  페이징--%>
<%--  <div class="paging-container">--%>
<%--    <div class="paging">--%>
<%--      <a class="page" href="#">&lt;</a>--%>
<%--      <a class="page" href="#">1</a>--%>
<%--      <a class="page" href="#">2</a>--%>
<%--      <a class="page" href="#">3</a>--%>
<%--      <a class="page" href="#">4</a>--%>
<%--      <a class="page paging-active" href="#">5</a>--%>
<%--      <a class="page" href="#">6</a>--%>
<%--      <a class="page" href="#">7</a>--%>
<%--      <a class="page" href="#">8</a>--%>
<%--      <a class="page" href="#">9</a>--%>
<%--      <a class="page" href="#">10</a>--%>
<%--      <a class="page" href="#">&gt;</a>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--  댓글창 --%>

<%--대댓글 숨어져 있음--%>
<%--<div id="replyForm" style="display:none">--%>
<%--  <input type="text" name="replyComment">--%>
<%--  <button id="wrtRepBtn" type="button"> 답글 등록</button>--%>
<%--</div>--%>

<div id="replyForm" style="display:none">
  <div class="commenter commenter-writebox">${id}</div>
  <div class="comment-writebox-content">
    <textarea name="replyComment" cols="20" rows="3" placeholder="댓글을 남겨보세요"></textarea>
  </div>
  <div id="comment-writebox-bottom">
    <div class="register-box">
      <button type="button"  id="wrtRepBtn"> 답글 등록</button>
    </div>
  </div>
</div>

<div id="modifyForm" style="display:none">
  <input type="text" name="modifyComment">
  <button id="wrtModBtn" type="button"> 수정완료</button>
</div>

<script>
  // bno는 게시물 번호
  let bno = 690;

  let showList = function(bno){
    $.ajax({
      type: 'GET',    // 요청 메서드
      url: '/ch4/comments?bno='+bno,  // 요청 URI , type 생략하면 json
      success : function(result){
        $("#comment-item").html(toHTML(result));    // 댓글목록 가져온걸 id commentList에 넣음
      },
      error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
    }); // $.ajax()
  }


  $(document).ready(function(){

    showList(bno);

    //댓글 달기의 등록 버튼
    $("#btn-write-comment").click(function(){
      let comment = $("textarea[name=comment]").val();

      if(comment.trim()==''){
        alert("댓글을 입력해주세요.");
        $("textarea[name=comment]").focus()
        return;
      }

      //comments?bno=1085 POST (답글이랑 비슷)
      $.ajax({
        type:'POST',       // 요청 메서드
        url: '/ch4/comments?bno='+bno,  // 요청 URI
        headers : { "content-type": "application/json"}, // 요청 헤더
        data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result);
          showList(bno); // 갱신
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
        $("textarea[name=comment]").val('')

    });


    $("#comment-item").on("click",".btn-modify",function() {
      // 1. modifyForm을 옮기고
      $("#modifyForm").appendTo($(this).parent().parent().children('.comment-content'));
      // 2. 답글을 입력할 폼을 보여 준다. (none -> block)
      $("input[name=modifyComment]").val('')
      $("#modifyForm").css("display","block");

    });

    $("#wrtModBtn").click(function(){
      let comment = $("input[name=modifyComment]").val();
      let cno = $(this).parent().parent().parent().parent().attr("data-cno");

      if(comment.trim()==''){
        alert("댓글 수정해주세요.");
        $("input[name=modifyComment]").focus()
        return;
      }


      //comments?bno=1085 POST
      $.ajax({
        type:'PATCH',       // 요청 메서드
        url: '/ch4/comments/'+cno,  // 요청 URI
        headers : { "content-type": "application/json"}, // 요청 헤더
        data : JSON.stringify({cno:cno, comment:comment}),
        // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result);
          showList(bno); // 갱신
        },
        error: function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()

      $("#modifyForm").css("display","none")
      $("input[name=modifyComment]").val('')
      $("#modifyForm").appendTo("body");
    });


    // 댓글의 답글을 누르면
    $("#comment-item").on("click",".btn-reply",function() {
      // 1. replyForm을 옮기고 (replyForm의 부모 즉 li에다 붙임)
      $("#replyForm").appendTo($(this).parent().parent().parent());
      // 2. 답글을 입력할 폼을 보여 준다. (none -> block)
      $("#replyForm").css("display","block");
    });


    // replyForm의 답글 등록 버튼을 눌렀을 때
    $("#wrtRepBtn").click(function(){
      let comment = $("textarea[name=replyComment]").val();
      let pcno = $("#replyForm").parent().attr("data-cno");

      if(comment.trim()==''){
        alert("답글을 입력해주세요.");
        $("textarea[name=replyComment]").focus()
        return;
      }

      //comments?bno=1085 POST
      $.ajax({
        type:'POST',       // 요청 메서드
        url: '/ch4/comments?bno='+bno,  // 요청 URI
        headers : { "content-type": "application/json"}, // 요청 헤더
        data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result);
          showList(bno); // 갱신
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()

      $("#replyForm").css("display","none")
      $("textarea[name=replyComment]").val('')
      $("#replyForm").appendTo("body");
    });


    //삭제 누르면 (o)
    $("#comment-item").on("click",".btn-delete",function(){
      let cno = $(this).parent().parent().parent().attr("data-cno");
      let bno = $(this).parent().parent().parent().attr("data-bno");

      $.ajax({
        type:'DELETE',       // 요청 메서드
        url: '/ch4/comments/'+cno+'?bno='+bno,  // 요청 URI , type 생략하면 json
        success : function(result){
          alert(result)
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
    });

  });

  let toHTML = function (comments){
    let tmp = "<ul>";

    comments.forEach(function (comment){
      tmp += '<li class="comment-item" data-cno=' + comment.cno
      tmp += ' data-pcno=' + comment.pcno
      tmp += ' data-bno=' + comment.bno + '>'
      tmp+='<span class="comment-img">'
      tmp+='<i class="fa fa-user-circle" aria-hidden="true"></i></span>'
      tmp += '<div class="comment-area">'

      // tmp += ' commenter=<span class="commenter">' + comment.commenter+ '</span>'
      // tmp += ' comment=<span class="comment">' + comment.comment + '</span>'
      tmp += '<div class="commenter">'
        if(comment.cno!=comment.pcno) tmp +='ㄴ'
      tmp += comment.commenter + '</div>'
      tmp += '<div class="comment-content">' + comment.comment + '</div>'
      tmp += '<div class="comment-bottom">'
      tmp += '  <span class="up_date">'+comment.up_date+'</span>'
      tmp += '  <button class="btn-reply">답글</button>'
      tmp += '  <button class="btn-modify">수정</button>'
      tmp += '  <button class="btn-delete">삭제</button>'
      tmp +='</div></div></li>'

    })
  return tmp+"</ul>";
  }

</script>
</body>
</html>