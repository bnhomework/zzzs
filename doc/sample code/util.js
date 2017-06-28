/**
 * @file ���÷���
 */
var callback_number = 1;
var jsonpcb = {};

var config = {
    // getProduceUrl: 'http://www.zizuozishou.com:8080/SSH/shareInteface',
    getProduceUrl: 'http://fx.zizuozishou.com/SSH/shareInteface',
    getProduceFn: 'getProduceById',
    getStudioFn: 'personCenter',
    getStudioProduceListFn: 'getDesinerProduceByState',
    addOrderFn: 'addOrder',
    getOrderByBuyerId: 'getOrderByBuyerIdState',
    payFn: 'payParameter',
    updateOrderFn: 'updateOrder',
    shareConfFn: 'configParameter',
    // getImgUrl: 'http://www.zizuozishou.com:8080/SSH/FileDownload.action?filename='
    getImgUrl: 'http://fx.zizuozishou.com/SSH/FileDownload.action?filename=',
    // getWorkList: 'http://fx.zizuozishou.com/SSH/mobileInteface',
    getWorkListFn: 'getRecommend',
    aliPayFn: 'aPayParameter'
};

var clothesdic = {
    cstyle:{
        '7':'cardigan',
        '6':'hatshirts',
        '4':'sweater',
        '8':'tshirt',
        '3':'tshirt'
    },
    sex:{
        '1':'male',
        '0':'female'
    },
    ccolor: {
        'white':'white',
        'gray':'gray',
        'black':'black',
        'yellow':'yellow',
        'blue':'blue',
        'cyan':'skyblue',
        'green':'green',
        'pink':'pink',
        'red':'red'
    },
    direction:{
        'front':'front.png',
        'back':'back.png'
    }
};

var util = {
    defaultTitle: '�����Լ�,�����������',
    defaultDetail: '���Լ���������ײ������<br/>���Լ�����������������<br/>���Լ�����������㽫��<br/>���Լ������룬��������<br/>',
    getImageUrl: function (pictrueId, width) {
        if (undefined === width || 0 > width) {
            width = 200;
        }

        return config.getImgUrl + pictrueId + '?w=' + width;
    },
    objToString: function (params) {
        var result = '';
        var data;
        var isFirst = true;
        for (var key in params) {
            data = params[key];

            if (isFirst) {
               result += key + '=';
            } else {
                result += '&' + key + '=';
            }

            if (typeof data === 'object') {
                result += JSON.stringify(data);
            } else {
                result += data;
            }

            isFirst = false;
        }

        return result;
    },
    jsonp: function (url, data, onload, fn) {
        var cbn = 'jsonpcb' + (callback_number++);
        fn = fn || 'callback';
        url = url + (url.indexOf('?') > -1 ? '&' : '?') + fn + '=window.jsonpcb.' + cbn;
        url +=  '&' + this.objToString(data);
        var s = document.createElement('script');
        window.jsonpcb[cbn] = function (response) {
            s.parentNode.removeChild(s);
            delete window.jsonpcb[cbn];
            onload && onload(null, response);
        }
        s.onerror = function () {
            s.parentNode.removeChild(s);
            delete window.jsonpcb[cbn];
            onload && onload('error');
        }
        s.src = url;
        s.type = 'text/javascript';
        document.body.appendChild(s);
    },
    post: function (url, data, callback, type) {
        var xhr = (function () {
            if (window.XMLHttpRequest) {
                return new XMLHttpRequest();
            } else {
                return new ActiveXObject('Microsoft.XMLHttp');
            }
        })();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
                    var data = JSON.parse(xhr.responseText);
                    callback(null, data);
                } else {
                    callback('error');
                }
            }
        };
        xhr.open('post', url);
        xhr.setRequestHeader('Content-Type', 'text/plain;charset=UTF-8');
        // xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        var dataStr = data;
        if (typeof data === 'object') {
            dataStr = JSON.stringify(data);
        }
        xhr.send(dataStr);
    },
    ajax: function (url, data, callback, method, type) {
        var xhr = (function () {
            if (window.ActiveXObject) {
              return new ActiveXObject('Microsoft.XMLHTTP');
            } else {
                return new XMLHttpRequest();
            }
        })();

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
                    var data = JSON.parse(xhr.responseText);
                    callback(null, data);
                } else {
                    callback('error');
                }
            }
        }

        if (!method) {
          method = 'get';
        }

        if ('post' !== method && typeof data === 'object') {
            url = url + (url.indexOf('?') > -1 ? '&' : '?') + this.objToString(data);
        }
        xhr.open(method, url);
        xhr.setRequestHeader('Content-Type', 'text/plain;charset=UTF-8');

        if ('post' === method) {
            var dataStr = data;
            if (typeof data === 'object') {
                dataStr = JSON.stringify(data);
            }
            xhr.send(dataStr);
        } else {
            xhr.send();
        }
    },
    gotoPage: function (loc, params) {
        if (!params || undefined === params) {
            window.location.href = loc;
            return;
        }

        loc = loc + (-1 < loc.indexOf('?') ? '&': '?');
        loc += this.objToString(params);

        window.location.href = loc;
    },
    ua: (function () {
        var ua = navigator.userAgent.toLowerCase();
        var isAndroid = ua.indexOf('android') > -1;
        var isIphone = ua.indexOf('iphone') > -1;
        var isIOS = ua.indexOf('iphone') > -1 || ua.indexOf('ipod') > -1 || ua.indexOf('ios') > -1;
        var isMobile = isAndroid || isIOS;
        var isWeiXin = ua.indexOf('micromessenger') > -1;
        var isChrome = ua.indexOf('chrome') > -1;
        return {
            isAndroid: isAndroid,
            isIOS: isIOS,
            isMobile: isMobile,
            isWeiXin: isWeiXin
        }
    })(),
    // ��������Y���ϵĹ�������
    getScrollTop: function () {
        var scrollTop = 0, bodyScrollTop = 0, documentScrollTop = 0;
        if(document.body){
            bodyScrollTop = document.body.scrollTop;
        }
        if(document.documentElement){
            documentScrollTop = document.documentElement.scrollTop;
        }
        scrollTop = (bodyScrollTop - documentScrollTop > 0) ? bodyScrollTop : documentScrollTop;
        return scrollTop;
    },
    // ��ȡ�ĵ��߶�
    getScrollHeight: function () {
        var scrollHeight = 0, bodyScrollHeight = 0, documentScrollHeight = 0;
        if(document.body){
            bodyScrollHeight = document.body.scrollHeight;
        }
        if(document.documentElement){
            documentScrollHeight = document.documentElement.scrollHeight;
        }
        scrollHeight = (bodyScrollHeight - documentScrollHeight > 0) ? bodyScrollHeight : documentScrollHeight;
        return scrollHeight;
    },
    // �ӿڸ߶�
    getWindowHeight: function () {
        var windowHeight = 0;
        if(document.compatMode == "CSS1Compat"){
            windowHeight = document.documentElement.clientHeight;
        }else{
            windowHeight = document.body.clientHeight;
        }
        return windowHeight;
    },
    // ��������
    getUrlParams: function (data) {
        if (!data) {
            return;
        }
        var paramsArray = data.split('&');
        var params = {};
        paramsArray.forEach(function (p) {
            var pa = p.split('=');
            params[pa[0]] = (pa[1] === undefined ? '' : pa[1]);
        });
        return params;
    },
    // ·��:classic male female
    router: function (e, app) {
        if (e) {
            e.preventDefault();
        }

        var params = this.getUrlParams(window.location.href.split('?')[1]);
        params.function = config.getProduceFn;

        if (params && params.agent) {
            app.$data.agent = params.agent;
        }

        var self = this;
        this.jsonp(config.getProduceUrl, params, function (error, data) {
            if ('error' === error || !data || !data.data || 0 != data.success) {
                // alert('show error page');
                self.gotoPage('../app/index.html');
                return;
            }

            var result = data.data;
            localStorage.data = JSON.stringify(result);
            app.$data.nick = result.nick;
            self.supportPersonalShare(app.$data.nick , window.location.href, 'http://' + window.location.host + '../../../static/images/share_logo.png');

            if (result.title && '' !== result.title.replace(/ /g, '')) {
                app.$data.title = result.title;
            } else {
                app.$data.title = self.defaultTitle;
            }
            if (result.content && '' !== result.content.replace(/ /g, '')) {
                app.$data.detail = result.content;
            } else {
                app.$data.detail = self.defaultDetail;
            }
            if (result.headurl && '' !== result.headurl.replace(/ /g, '')) {
                // app.$data.avatarUrl = config.getImgUrl + result.headurl;
                app.$data.avatarUrl = self.getImageUrl(result.headurl, 70);
            }

            var displayImgs = app.$data.workDisplayImgs;
            var popupDisplayImgs = app.$data.popupDisplayImgs;
            if (result.pictureUrl && '' !== result.pictureUrl.replace(/ /g, '')) {
                // displayImgs.frontUrl = popupDisplayImgs.frontUrl = config.getImgUrl + result.pictureUrl;
                displayImgs.frontUrl = popupDisplayImgs.frontUrl = self.getImageUrl(result.pictureUrl);
                popupDisplayImgs.pictureUrl = result.pictureUrl;
            }
            if (result.pictureUrlBack && '' !== result.pictureUrlBack.replace(/ /g, '')) {
                // displayImgs.backUrl = popupDisplayImgs.backUrl = config.getImgUrl + result.pictureUrlBack;
                displayImgs.backUrl = popupDisplayImgs.backUrl = self.getImageUrl(result.pictureUrlBack);
                popupDisplayImgs.pictureUrlBack = result.pictureUrlBack;
            }
            displayImgs.frontbgUrl = popupDisplayImgs.frontbgUrl = self.getClothes(result.moldId, result.color, result.gender, 'front');
            displayImgs.backbgUrl = popupDisplayImgs.backbgUrl = self.getClothes(result.moldId, result.color, result.gender, 'back');
            popupDisplayImgs.produceId = params.produceId;

            var infoId = result.moldId + '_' + result.gender;
            app.$data.goodsOptions = self.clothesData[infoId];

            var defaultOptions = {};
            defaultOptions.moldId = result.moldId;
            defaultOptions.sex = result.gender;
            defaultOptions.type = 1;
            defaultOptions.ccolor = result.color;
            defaultOptions.size = result.size;
            defaultOptions.price = result.price;
            defaultOptions.matsPrice = result.matsPrice;
            defaultOptions.pictureUrl = result.pictureUrl;
            defaultOptions.pictureUrlBack = result.pictureUrlBack;
            defaultOptions.percent = result.percent;
            app.$data.defultSelectedOptions = defaultOptions;
        });
    },
    clothesData: {
      '3_1':{ //T����
          model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'},
                   {key: 0, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'},
                    {key: 'yellow', name: '#f8f12a'},
                    {key: 'green', name: '#149150'},
                    {key: 'blue', name: '#000079'},
                    {key: 'cyan', name: '#00FFFF'},
                    {key: 'red', name: '#ee2e1f'}
              ],
          experienceColor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'},
                   {key: '3XL', name: '3XL'}
                ]
      },
      '3_0':{ //T��Ů
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'},
                   {key: 0, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'},
                    {key: 'yellow', name: '#f8f12a'},
                    {key: 'pink', name: '#ffb8d0'},
                    {key: 'green', name: '#149150'},
                    {key: 'blue', name: '#000079'},
                    {key: 'cyan', name: '#00FFFF'},
                    {key: 'red', name: '#ee2e1f'}
              ],
          experienceColor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'}
              ],
          size: [  {key: 'S', name: 'S'},
                   {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '4_1':{ //������
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'},
                    {key: 'yellow', name: '#f8f12a'},
                    {key: 'blue', name: '#000079'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'},
                   {key: '3XL', name: '3XL'}
                ]
      },
      '4_0':{ //����Ů
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'yellow', name: '#f8f12a'},
                    {key: 'green', name: '#149150'},
                    {key: 'blue', name: '#000079'},
                    {key: 'cyan', name: '#00FFFF'},
                    {key: 'red', name: '#ee2e1f'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '6_1':{ //ñ����
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '6_0':{ //ñ��Ů
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '7_1':{ //������
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '7_0':{ //����Ů
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'}
              ],
          size: [  {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '8_1':{ //ͯװ��
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'},
                    {key: 'yellow', name: '#f8f12a'},
                    {key: 'green', name: '#149150'},
                    {key: 'blue', name: '#000079'},
                    {key: 'cyan', name: '#00FFFF'},
                    {key: 'red', name: '#ee2e1f'}
              ],
          size: [  {key: 'S', name: 'S'},
                   {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      },
      '8_0':{ //ͯװŮ
        model: [{key: 3, name: 't��'},
                  {key: 4, name: '����'},
                  {key: 6, name: 'ñ��'},
                  {key: 7, name: '����'},
                  {key: 8, name: '��ͯ��'}
                 ],
          sex: [  {key: 1, name: '�п�'},
                  {key: 0, name: 'Ů��'}
               ],
          type: [  {key: 1, name: '�����'}
                ],
          ccolor: [ {key: 'white', name: '#ffffff'},
                    {key: 'gray', name: '#99989e'},
                    {key: 'black', name: '#000000'},
                    {key: 'yellow', name: '#f8f12a'},
                    {key: 'green', name: '#149150'},
                    {key: 'blue', name: '#000079'},
                    {key: 'cyan', name: '#00FFFF'},
                    {key: 'red', name: '#ee2e1f'}
              ],
          size: [  {key: 'S', name: 'S'},
                   {key: 'M', name: 'M'},
                   {key: 'L', name: 'L'},
                   {key: 'XL', name: 'XL'},
                   {key: '2XL', name: '2XL'}
                ]
      }
    },
    getClothes: function (moldId, color, gender, direction) {
        var url = 'static/images/clothes',
        url = url + '/' + clothesdic.cstyle[moldId];
        url = url + '/' + clothesdic.sex[gender];
        url = url + '/' + clothesdic.ccolor[color];
        url = url + clothesdic.direction[direction];
        return url;
    },
    supportWeixinShare: function (shareData) {
        // ����΢�ŵĶ��η���
        var ua = navigator.userAgent.toLowerCase();
        var isWeiXin = ua.indexOf('micromessenger') > -1;
        if (isWeiXin) {
            this.jsonp(config.getProduceUrl, {function: config.shareConfFn, url: encodeURIComponent(window.location.href.split('#')[0])}, function (error, data) {
                if (error !== 'error') {
                    var config = data;
                    // -1���󣺻�ȡ����Token;
                    // -2���󣺻�ȡ����Ticket;
                    if ('-1' == config.retcode || '-2' == config.retcode) {
                        return;
                    }

                    // �Ƿ�Ϊ����״̬��falseΪ��
                    config.debug = false;
                    // ��Ҫʹ�õĽӿ��б�
                    config.jsApiList = ['onMenuShareAppMessage', 'onMenuShareTimeline'];
                    wx.config(config);
                    // �����֤ͨ����Ļص�
                    wx.ready(function () {
                        // config��Ϣ��֤���ִ��ready���������нӿڵ��ö�������config�ӿڻ�ý��֮��config��һ���ͻ��˵��첽���������������Ҫ��ҳ�����ʱ�͵�����ؽӿڣ��������ؽӿڷ���ready�����е�����ȷ����ȷִ�С������û�����ʱ�ŵ��õĽӿڣ������ֱ�ӵ��ã�����Ҫ����ready�����С�
                        // ��ȡ����������Ȧ����ť���״̬���Զ���������ݽӿ�
                        wx.onMenuShareTimeline({
                            title: shareData.desc, // �������
                            link: shareData.url, // ��������
                            imgUrl: shareData.imgUrl, // ����ͼ��
                            success: function () {
                                // �û�ȷ�Ϸ����ִ�еĻص�����
                            },
                            cancel: function () {
                                // �û�ȡ�������ִ�еĻص�����
                            }
                        });
                        // ��ȡ����������ѡ���ť���״̬���Զ���������ݽӿ�
                        wx.onMenuShareAppMessage({
                            title: shareData.title, // �������
                            desc: shareData.desc, // ��������
                            link: shareData.url, // ��������
                            imgUrl: shareData.imgUrl, // ����ͼ��
                            type: 'link', // ��������,music��video��link������Ĭ��Ϊlink
                            dataUrl: '', // ���type��music��video����Ҫ�ṩ�������ӣ�Ĭ��Ϊ��
                            success: function () {
                                // �û�ȷ�Ϸ����ִ�еĻص�����
                            },
                            cancel: function () {
                                // �û�ȡ�������ִ�еĻص�����
                            }
                        });
                    });

                    wx.error(function(res){
                        // config��Ϣ��֤ʧ�ܻ�ִ��error��������ǩ�����ڵ�����֤ʧ�ܣ����������Ϣ���Դ�config��debugģʽ�鿴��Ҳ�����ڷ��ص�res�����в鿴������SPA�������������ǩ����
                    });
                }
            });
        }
    },
    supportAppShare: function (url, imgUrl) {
        var shareData = {
            title: '��������',
            desc: '@�������� С����ǣ�����һ�������APP�������ң����������ۡ���Just Me��û��ʲô���赲�ҵĴ������������ʦ����Ϊ�Լ�����',
            url: url,
            imgUrl: imgUrl
        };
        this.supportWeixinShare(shareData);
    },
    supportPersonalShare: function (username, url, imgUrl) {
        var shareData = {
            title: '����' + username + '�����',
            desc: 'Just Me��û��ʲô���赲�ҵĴ������������ʦ����Ϊ�Լ�����!',
            url: url,
            imgUrl: imgUrl
        };
        this.supportWeixinShare(shareData);
    },
    supportShakeShare: function (url, imgUrl) {
        var shareData = {
            title: '��������',
            desc: 'ҡһҡ�봴T�����д�����ѹ��׬ȡӶ��',
            url: url,
            imgUrl: imgUrl
          };
        this.supportWeixinShare(shareData);
    }
};