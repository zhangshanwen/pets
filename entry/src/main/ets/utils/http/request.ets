import http from '@ohos.net.http';
//导入预定好的数据响应格式
import Response from './response'
import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { getAuthorization } from '../user';


//导出去一个请求函数，这样开发者就可以像axios一样的风格请求数据
export function request(url: string, method: http.RequestMethod, data?: {}): Promise<Response> {
  //定义一个后台请求的基地址
  const BASE_URL = "http://192.168.1.3:17017/api/"
  let httpRequest = http.createHttp();
  let header = {
    'authorization': getAuthorization()
  }
  let extraData = ''
  if ([http.RequestMethod.GET, http.RequestMethod.DELETE, http.RequestMethod.OPTIONS, http.RequestMethod.TRACE, http.RequestMethod.CONNECT].lastIndexOf(method) < 0) {
    header['Content-Type'] = 'application/json'
    extraData = JSON.stringify(data)
  } else {
    let params = []
    for (var key in data) {
      params.push(`${key}=${data[key]}`)
    }
    extraData = params.join("&")
  }

  let responseResult = httpRequest.request(BASE_URL + url, {
    method: method,
    header: header,
    //携带额外参数
    extraData: extraData,
    // 可选，指定返回数据的类型
    // expectDataType: http.HttpDataType.STRING,
    // 可选，默认为true
    // usingCache: true,
    // 可选，默认为1
    // priority: 1,
    // 可选，默认为60000ms
    // connectTimeout: 60000,
    // readTimeout: 60000,
    // 可选，协议类型默认值由系统自动指定
    // usingProtocol: http.HttpProtocol.HTTP1_1,
  });

  let response = new Response();
  // 处理数据，并返回
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === 200) {
      // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
      // 这里建议和后端的保持一致
      let res: Response = JSON.parse(`${value.result}`);
      if (res.code == -1) {
        // 登录检验失败,删除登录态
        // TODO 使用freshToken 重新刷新
        router.pushUrl({
          url: CommonConstants.LOGIN_PAGE_URL
        })
      } else if (res.code == 1) {
        throw new Error(res.msg)
      }
      response.data = res.data;
      response.code = res.code;
      response.msg = res.msg;
      response.req_id = res.req_id;
      return response
    } else {
      throw new Error('系统错误');
    }
    return response
  }).catch((err) => {
    AlertDialog.show({
      title: '系统错误',
      message: '',
      autoCancel: true,
      alignment: DialogAlignment.Bottom,
      offset: { dx: 0, dy: -20 },
      gridCount: 3,
      confirm: {
        value: '确认',
        action: () => {
        }
      },
    })
    throw err
  }).finally(() => {
    httpRequest.destroy()
  });

}

