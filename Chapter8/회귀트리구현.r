#######################optim사용#############################################################
set.seed(1)
x<-runif(100)
set.seed(2)
y<-3*x+20*rnorm(100)+35-runif(100)*30-50*rpois(100,0.3)
summary(x)
summary(y)

#optim 분할기준(회귀)
min.RSS <- function(par) {
  return(sum(c((y[x<par]-(lm(y[x<par]~x[x<par])$coef[1]+
                            x[x<par]*lm(y[x<par]~x[x<par])$coef[2]))^2,
               (y[x>=par]-(lm(y[x>=par]~x[x>=par])$coef[1]+
                             x[x>=par]*lm(y[x>=par]~x[x>=par])$coef[2]))^2)))
}

cur<-c()
for(i in 1:94){
  ii<-0.01*i+0.02
  cur[i]<-min.RSS(ii)
}
plot(c(1:94)*0.01+0.02,cur,type='l')
text(0.01*which.min(cur)+0.02,cur[which.min(cur)]-10,
     0.01*which.min(cur)+0.02,col='red')
?optimize
result2 <- optimize(min.RSS,c(0.5,1))
result <- optim(par=0.95, lower = 0.03, upper = 0.96,fn=min.RSS,  method="Brent")
result

result <- optim(par=0.95, lower = 0.8, upper = 1,fn=min.RSS,  method="Brent")
result

#범위에 따라 결과값이 너무 다르게 나옴.

################################################################################################
library(MASS)
data(Boston)
set.seed(1)
train<-sample(1:nrow(Boston),nrow(Boston)/2)
train.boston<-Boston[train,]
test.boston<-Boston[-train,]


attach(Boston)

#optim 분할기준(회귀)
min.RSS <- function(par) {
  return(sum(c((y[x<par]-(lm(y[x<par]~x[x<par])$coef[1]+
                            x[x<par]*lm(y[x<par]~x[x<par])$coef[2]))^2,
               (y[x>=par]-(lm(y[x>=par]~x[x>=par])$coef[1]+
                             x[x>=par]*lm(y[x>=par]~x[x>=par])$coef[2]))^2)))
}
################################################step1###########################################
cur1<-c()
x<-train.boston$lstat
y<-train.boston$medv
names(train.boston)
j=1
for(i in ceiling(range(x)[1]+0.5):floor(range(x)[2]-0.5)){
  cur1[j]<-min.RSS(i)
  j<-j+1
}
plot(ceiling(range(x)[1]+0.5):floor(range(x)[2]-0.5),cur1,type='l')
minx<-which.min(cur1)+ceiling(range(x)[1]+0.5)-1
minx
###########################################################################
result1 <- optim(par=mean(x), lower = range(x)[1], 
                 upper = floor(range(x)[2]-1),fn=min.RSS,  method="Brent")
result1
############################################################################
t1<-train[train.boston$lstat<minx]
t2<-train[train.boston$lstat>=minx]
##############################최소RSS 구하는 함수###########################################################

normal_step<-function(lstat,medv){
  x<-lstat
  y<-medv
  cur1<-c()
  j=1
  for(i in ceiling(range(x)[1]+0.5):floor(range(x)[2]-0.5)){
    cur1[j]<-min.RSS(i)
    j<-j+1
  }
  plot(ceiling(range(x)[1]+0.5):floor(range(x)[2]-0.5),cur1,type='l')
  minx<-which.min(cur1)+ceiling(range(x)[1]+0.5)-1
  minx
  points(minx,cur1[which.min(cur1)],pch=20,col='green')
  return(c(minx,cur1[which.min(cur1)]))
}

########################################################################################
x<-train.boston$rm;y<-train.boston$medv;normal_step(train.boston$rm,train.boston$medv)
x<-train.boston$dis;y<-train.boston$medv;normal_step(train.boston$dis,train.boston$medv)
x<-train.boston$ptratio;y<-train.boston$medv;normal_step(train.boston$ptratio,train.boston$medv)
#x<-train.boston$crim;y<-train.boston$medv;normal_step(train.boston$rim,train.boston$medv)
x<-train.boston$zn;y<-train.boston$medv;normal_step(train.boston$zn,train.boston$medv)
x<-train.boston$indus;y<-train.boston$medv;normal_step(train.boston$indus,train.boston$medv)
#x<-train.boston$chas;y<-train.boston$medv;normal_step(train.boston$chas,train.boston$medv)
#x<-train.boston$nox;y<-train.boston$medv;normal_step(train.boston$nox,train.boston$medv)
x<-train.boston$age;y<-train.boston$medv;normal_step(train.boston$age,train.boston$medv)
x<-train.boston$rad;y<-train.boston$medv;normal_step(train.boston$rad,train.boston$medv)
x<-train.boston$tax;y<-train.boston$medv;normal_step(train.boston$tax,train.boston$medv)
x<-train.boston$black;y<-train.boston$medv;normal_step(train.boston$black,train.boston$medv)
x<-train.boston$lstat;y<-train.boston$medv;normal_step(train.boston$lstat,train.boston$medv)

#> x<-train.boston$lstat;y<-train.boston$medv;normal_step(train.boston$lstat,train.boston$medv)
#[1]    5 6690

cri<-normal_step(train.boston$lstat,train.boston$medv)[1]
t1<-train.boston[train.boston$lstat<cri,]
t2<-train.boston[train.boston$lstat>=cri,]
t1.test<-test.boston[test.boston$lstat<cri,]
t2.test<-test.boston[test.boston$lstat>=cri,]

#step2-1

x<-t1$rm;y<-t1$medv;normal_step(t1$rm,t1$medv)
x<-t1$dis;y<-t1$medv;normal_step(t1$dis,t1$medv)
x<-t1$ptratio;y<-t1$medv;normal_step(t1$ptratio,t1$medv)
#x<-t1$crim;y<-t1$medv;normal_step(t1$rim,t1$medv)
x<-t1$zn;y<-t1$medv;normal_step(t1$zn,t1$medv)
x<-t1$indus;y<-t1$medv;normal_step(t1$indus,t1$medv)
#x<-t1$chas;y<-t1$medv;normal_step(t1$chas,t1$medv)
#x<-t1$nox;y<-t1$medv;normal_step(t1$nox,t1$medv)
x<-age;y<-medv;normal_step(age,medv)
x<-t1$rad;y<-t1$medv;normal_step(t1$rad,t1$medv)
x<-t1$tax;y<-t1$medv;normal_step(t1$tax,t1$medv)
x<-t1$black;y<-t1$medv;normal_step(t1$black,t1$medv)
x<-t1$lstat;y<-t1$medv;normal_step(t1$lstat,t1$medv)

#> x<-t1$rm;y<-t1$medv;normal_step(t1$rm,t1$medv)
#[1]   7 491

x<-t1$rm;y<-t1$medv;cri<-normal_step(t1$rm,t1$medv)[1]
t3<-t1[t1$rm<cri,]
t4<-t1[t1$rm>=cri,]
t3.test<-t1.test[t1.test$rm<cri,]
t4.test<-t1.test[t1.test$rm>=cri,]

#step2-2
sum(is.na(Boston))
x<-t2$rm;y<-t2$medv;normal_step(t2$rm,t2$medv)
x<-t2$dis;y<-t2$medv;normal_step(t2$dis,t2$medv)
x<-t2$ptratio;y<-t2$medv;normal_step(t2$ptratio,t2$medv)
#x<-t2$crim;y<-t2$medv;normal_step(t2$rim,t2$medv)
x<-t2$zn;y<-t2$medv;normal_step(t2$zn,t2$medv)
x<-t2$indus;y<-t2$medv;normal_step(t2$indus,t2$medv)
#x<-t2$chas;y<-t2$medv;normal_step(t2$chas,t2$medv)
#x<-t2$nox;y<-t2$medv;normal_step(t2$nox,t2$medv)
x<-age;y<-medv;normal_step(age,medv)
x<-t2$rad;y<-t2$medv;normal_step(t2$rad,t2$medv)
x<-t2$tax;y<-t2$medv;normal_step(t2$tax,t2$medv)
x<-t2$black;y<-t2$medv;normal_step(t2$black,t2$medv)
x<-t2$lstat;y<-t2$medv;normal_step(t2$lstat,t2$medv)

#x<-t2$lstat;y<-t2$medv;normal_step(t2$lstat,t2$medv)
#[1]   10 4782

x<-t2$lstat;y<-t2$medv;cri<-normal_step(t2$lstat,t2$medv)[1]
t5<-t2[t2$lstat<cri,]
t6<-t2[t2$lstat>=cri,]
t5.test<-t2.test[t2.test$rm<cri,]
t6.test<-t2.test[t2.test$rm>=cri,]

##################################################################

tree.boston<-tree(medv~.,subset=train,data=train.boston)
summary(tree.boston)
plot(tree.boston)
text(tree.boston,pretty=0)

cv.boston<-cv.tree(tree.boston)
plot(cv.boston$size,cv.boston$dev,type="b")

prune.boston<-prune.tree(tree.boston,best=4)
plot(prune.boston)
text(prune.boston,pretty=0)

yhat<-predict(prune.boston,newdata=Boston[-train,])
boston.test<-Boston[-train,"medv"]
plot(yhat,boston.test)
abline(0,1)
mean((yhat-boston.test)^2)

#> mean((yhat-boston.test)^2)
#[1] 32.5
lm.t1<-lm(medv~.,subset=train,data=t1)
summary(lm.t1)
yhat1<-predict(lm.t1,newdata=c(crim =1,          zn =1,       indus=1,         
chas=1,          nox =1,          rm=1,age=1,
dis=1, rad=1,          tax=1,      
ptratio=1,        black=1,        lstat=1,medv=1))
plot(yhat1,lm.t1)
abline(0,1)
mean((yhat1-boston.test)^2)

