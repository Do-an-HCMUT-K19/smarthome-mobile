class ReturnMessage {
  var code, message, data;
  ReturnMessage(this.code, this.message);
  ReturnMessage.data(this.code, this.message, this.data);
}
// Return Message
// code 200, request ok
// code 400, missing value
