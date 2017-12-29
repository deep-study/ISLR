http://blog.naver.com/PostView.nhn?blogId=lool2389&logNo=220818733086&redirect=Dlog&widgetTypeCall=true

#X=x0에서의 국소회귀
#1.훈련 포인트들의 xi가 x0에 가장 가까운 일부 s=k/n을 모은다.
#2.이 이웃의 각 점에서 가중치 Ki0=K(xi,x0)을 할당한다.
#x0에서 가장 먼 점은 가중치가 영이고 가장 가까운 점은 가장 높은 가중치를 가진다.
#k개의 최근접이웃 이외의 모든 점은 가중치가 영이다.
#3.앞의 가중치를 사용하여 식 7.14를 최소로 하는 beta0hat,beta1hat을 찾음으로써 xi에 yi의
#가중최소제곱회귀를 적합한다.
#시그마i=1 to n Ki0*(yi-beta0-beta1*xi)^2
#4.x0에서 적합된 값은 fhat(x0)=beta0hat+beta1hat*x0로 주어진다.
set.seed(1)
x<-seq(1,100,by=1)
y<-abs(100*rnorm(100))
plot(x,y,type='l')
range(y)# 1.836433 15.952808
length(x)

localRegression<-function(x,y,s){
  k<-s*length(x)
  x0<-c()
  y0<-c()
  spx<-c()
  spy<-c()
  new_x<-seq(min(range(x)),max(range(x)),by=0.1)
  for(i in 1:length(new_x)){
    diff<-abs(new_x[i]-x)
    xx<-x[order(diff)]
    yy<-y[order(diff)]
    for(j in 1:k){
      x0[j]<-xx[j]
      y0[j]<-yy[j]
    }
    K<-ifelse(x0==0|(1-x0/sum(x0))==0,1,(1-x0/sum(x0))/sum(1-x0/sum(x0)))
    spx[i]<-mean(x0)
    spy[i]<-sum(K*y0)
  }
  plot(x,y)
  points(spx,spy,type='l',col="red")
}
localRegression(x,y,0.02)

