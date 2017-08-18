import config from '@/config'
const serverAddress = config.apiServer
const imgServer = config.imgServer
const utils = {
  created() {
    this.setOpenId();
  },
  methods: {
    setOpenId() {
      var openId = this.$route.params.openId;
      if (openId != undefined && openId != '') {
        this.$store.commit("updateOpenId", {
          openId: this.$route.params.openId
        })
      }
    },
    doPayment(order, cb, fcb) {
      var vm = this;
      this.$wechat.chooseWXPay({
        timestamp: order.timeStamp,
        nonceStr: order.nonceStr,
        package: order.package,
        signType: order.signType,
        paySign: order.paySign,
        success: function(res) {
          vm.$vux.toast.show({ text: res });
          if (res.errMsg == "chooseWXPay:ok") {
            vm.$vux.toast.show({
              text: '支付成功！'
            })

            if (cb) {
              cb();
            }
          } else {
            vm.$vux.toast.show({
              text: '支付失败！',
              type: 'cancel'
            });
            if (fcb) {
              fcb();
            }
          }
        }
      });
    },
    getImgSrc(src) {
      if (src == undefined || src == '') {
        return "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAAuCAMAAABgZ9sFAAAAVFBMVEXx8fHMzMzr6+vn5+fv7+/t7e3d3d2+vr7W1tbHx8eysrKdnZ3p6enk5OTR0dG7u7u3t7ejo6PY2Njh4eHf39/T09PExMSvr6+goKCqqqqnp6e4uLgcLY/OAAAAnklEQVRIx+3RSRLDIAxE0QYhAbGZPNu5/z0zrXHiqiz5W72FqhqtVuuXAl3iOV7iPV/iSsAqZa9BS7YOmMXnNNX4TWGxRMn3R6SxRNgy0bzXOW8EBO8SAClsPdB3psqlvG+Lw7ONXg/pTld52BjgSSkA3PV2OOemjIDcZQWgVvONw60q7sIpR38EnHPSMDQ4MjDjLPozhAkGrVbr/z0ANjAF4AcbXmYAAAAASUVORK5CYII="
      } else if (src.indexOf('data:') >= 0) {
        return src;
      } else if (src.indexOf('wxLocalResource:') >= 0) {
        return src;
      }
      return imgServer + src;
    },
    getCurrentDate() {
      var today = new Date();
      var dd = today.getDate();
      var mm = today.getMonth() + 1;
      var yyyy = today.getFullYear();
      if (dd < 10) {
        dd = '0' + dd;
      }
      if (mm < 10) {
        mm = '0' + mm;
      }
      return `${yyyy}-${mm}-${dd}`;
    },
    getOrderStatus(s) {
      var status = '';
      if (s == 20) {
        status = '等待生产';
      } else if (s == 30) {
        status = '正在生产'
      } else if (s == 40) {
        status = '申请退款'
      } else if (s == 50) {
        status = '已完成'
      } else if (s = 60) {
        status = '已退款'
      }
      return status;
    },
    goTo(p) {
      this.$router.push(p)
    }
  },
  computed: {
    apiServer() {
      return config.apiServer;
    }
  }
}
export default utils
