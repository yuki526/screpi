function list () {
  // 追加ボタンを取得
  const submit = document.getElementById("list-submit");

  submit.addEventListener("click", (e) => {

    // フォームの要素を取得
    const formData = new FormData(document.getElementById("form"));

    // XMLHttpRequestのオブジェクトを生成
    const XHR = new XMLHttpRequest();

    // リクエストの定義
    // 第一引数：HTTPメソッド、第二引数：URL、第三引数：非同期通信であることを示すtrue
    XHR.open("POST", "/lists", true);
    XHR.responseType = "json";

    // フォームに入力された情報を送信
    XHR.send(formData);


    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }

      // レスポンスとして返却された品目名を取得
      const response = XHR.response;
      const name = response['name'];
      
      debugger

      // 表示する要素の親要素を取得
      const list = document.getElementById("list");

      // フォームに入力された値をリセットするために取得
      const formText = document.getElementById("content");


      // 入力された値を描写
      const HTML = `<li class="list-item">${name}</li>`;

      // 描写を挿入
      list.insertAdjacentHTML("beforeend", HTML);

      // フォームの値をリセット
      formText.value = "";
    }
    // コントローラーの処理を止める
    e.preventDefault();

  });

}

window.addEventListener("load", list);