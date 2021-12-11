class DataList{
  static const url = "https://jeil.pythonanywhere.com/";
  static final menuName = ['한식','분식','카페','일식','치킨','피자','양식','중식','도시락','패스트푸드','기타'];
  static final List<String> questionCategory = ['계정','이용문의','불편사항','정보등록','기타'];
}
enum Appbar_mode {main, search, detail,menu}

enum URL{currentLocation, login, signUp, accoutOut, updateNickname, updateImage,
  updatePassword, findAccount, selectMyReview, selectMyHouse, createQnA, selectMyQuestion,
  selectFAQ, createReview, deleteReview, createHouse, updateHouse, selectCategoryHouse,
  selectLocationHouse, selectSearchHouse, selectHouseName, selectHouseInfo, selectHouseMenu,
  selectHouseReview, selectNotice}