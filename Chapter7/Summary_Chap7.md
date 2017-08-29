7. 선형성을 넘어서

선형모델은 설명과 실현이 비교적 단순하고 해석과 추론 측면에서 다른 기법들에 비해 장점이 있다. 하지만 표준적인 선형회귀는 예측능력면에서 상당히 제한 적일 수 있다. 왜냐하면 선형이란 가정은 거의 항상 근사적이고 때로는 잘 맞지도 않기 때문이다. 6장에서는 능형회귀, lasso, 주성분회귀, 그리고 다른 기법들을 사용하여 선형회귀를 향상시킬 수 있음을 살펴보았다. 이러한 향상은 성형모델의 복잡도를 줄여 추정치들의 분산을 줄임으로써 얻어진다. 그러나 여전히 선형모델을 사용하므로 개선은 한정적이다. 이 장에서는 해석력은 여전히 가능한 한 높게 유지하면서 선형성에 대한 가정은 완화하고자 한다. 이것을 위해, 다항식회귀와 계단함수와 같은 선형모델들의 아주 단순한 확장 뿐만 아니라 스플라인, 국소회귀 그리고 일반화가법모델과 같은 좀 더 정교한 기법들을 살펴본다.

다항식회귀 – 원래의 설명변수 각각을 거듭제곱하여 얻은 추가적인 설명변수들을 포함하여 선형모델을 확장한다.
계단함수 – 변수의 범위를 K개의 영역으로 구분하여 질적 변수를 생성한다. 이것은 조각별 상수함수(piecewise constant function)를 적합하는 효과를 가진다.
회귀스플라인 – 다항식 함수와 계단함수보다 더 유연하며 사실상 이 두 함수의 확장이다. 이것은 X의 범위를 K개의 영역으로 나누는 것을 포함한다. 각 영역 내에서 함수가 데이터에 적합된다. 하지만 이들 다항식은 영역의 경계에서 매끄럽게 연결되거나 매듭이 되도록 제한된다. 구간이 충분한 수의 영역으로 나누어지면 적합은 아주 유연하게 될 수 있다.
평활스플라인 – 회귀스플라인과 유사, 평활도 페널티 조건하에서 잔차제곱합 기준을 최소로 한 결과
국소회귀 – 스플라인과 유사, 영역들이 겹칠 수 있으며 실제로 아주 매끄러운 방식으로 겹쳐질 수 있다.
일반화가법모델 – 다중 설명변수들을 다룰 수 있도록 위에서 설명한 방법들을 확장할 수 있게 한다.


- 7.1-7.5은 기저함수, 단일 설명함수
- 7.6은 국소회귀, 단일 설명함수
- 7.7은 일반화가법모델, 여러 개의 설명변수

7.1 다항식회귀
거듭제곱된 설명변수 사용 

![pic1]("http://postfiles1.naver.net/MjAxNzA4MjlfNDAg/MDAxNTA0MDE3MTY0NTQw.5ayJI_OVVAPcRiPQbfwyafTbhLzirLH68l3wbPYTYXgg.8Mhtd9FMkmax6j6sMVBFDQfZ4JHDbGC-D4_M7w5RW6Ig.PNG.o_oaill/pic1.png?type=w1")

T> 그림 7.1 만들어보자

7.2 계단함수
X의 범위를 여러 개의 빈(bin)으로 분할하여 각 bin에 다른 상수들을 적합한다 -> 연속적인 변수를 순서범주형 변수로 변환하는 것이다. K개의 절단점(cutpoint)을 사용하여 K+1개의 새로운 변수를 만든다. 조각별 상수회귀모델이다. 차수가 0인 조각별 다항식이다.

T> 그림 7.2만들어보자
7.3 기저함수
T> 위의 7.1, 7.2에 나온 다항식 및 조각별 상수회귀모델들은 기저함수 기법의 특별한 경우이다. 
7.4 회귀 스플라인
다항식 및 조각별 상수회귀 기법을 확장하는 유연한 클래스의 기저함수이다.
조각별 다항회귀(piecewise polynomial regression)는 X의 범위를 구분하여 각 범위에 저차원 다항식을 적합한다.
-경계가 있는 삼차다항식(Piecewise cubic)
-경계에서 연속적인 삼차다항식(Continuous piecewise cubic)
-경계에서 연속적이고 2차 도함수까지 연속인 삼차다항식(Cubic spline)
-경계에서 연속적인 선형스플라인(Linear spline)
-경계에서 선형인 자연스플라인(Natural spline) : 일반적으로 경계에서 안정적인 추정치를 제공한다.
회귀스플라인들은 종종 다항식 회귀에 비해 월등히 좋은 결과를 주고, 안정적인 추정치들을 제공한다. (제한을 줄 수 있기 때문에 - 경계에서 선형, 연속, 차원수 제한)
![pic2]("http://postfiles10.naver.net/MjAxNzA4MjlfMTk3/MDAxNTA0MDE3MTY0MDI3.4BkwzjxUmAf4PUYONWqPTsRfPPolm2VtSKPoQnSLyDUg.i5fM9BtPsxycRg_7VQkm8ay4TNj3HGL3jLHJB8lRlOAg.PNG.o_oaill/pic2.png?type=w1")

7.5 평활 스플라인
데이터에 평활한 곡선을 적합하는데 있어서 원하는 것은 관측된 데이터에 잘 맞는 RSS를 가장 작게 하는 함수g를 찾는 것이다. 모든 관측치를 보간(interpolate)하도록 함수g를 선택함으로써 항상 RSS가 영이 되게 할 수 있다. 이러한 함수는 데이터를 극도로 과적합할 것이고 지나치게 유연할 것이다. 우리가 정말로 원하는 것은 RSS를 작게 하지만 또한 평활한 함수g이다.
그래서 여기서는 능형회귀와 lasso와 관련하여 보았던 “손실함수+패널티”형태이다. 패널티에 들어있는 2차 도함수는 아주 구불구불하면 절대값은 크고 평활하면 작은 절대값을 가진다. 그리고 람다값(패널티)이 클수록 g는 더 평활해질 것이다.
즉, 이 함수는 모든 xi에 매듭이 있는 조각별 삼차 다항식이고, 이 함수의 1차 도함수와 2차 도함수는 각 매듭에서 연속적이다. 그리고 이 함수는 극단적인 매듭 이외의 영역에서는 선형이다. 즉, 저 식을 최소로 하는 함수 g는 모든 xi에 매듭이 있는 자연 삼차 스플라인이다. 이것은 수축된 버전의 자연 삼차 스플라인이다.
평활 스플라인은 모든 xi에 매듭이 있는 단순히 자연 삼차 스플라인이다. 조율 파라미터 람다가 평활스플라인의 roughness를 제어하여 유효자유도(df람다)를 제어하기 떄문에 지나치게 많은 자유도를 가지지는 않는다.  자유도n을 가지는 평활 스플라인은 n개의 파라미터들이 심하게 제한되거나 수축되기 때문에 유효자유도는 평활 스플라인의 유연성에 대한 측도이다. 유효자유도가 높을 수록 평활 스플라인은 더 유연하다(편향은 더 낮고 분산은 더 높다)

![pic3]("http://postfiles13.naver.net/MjAxNzA4MjlfMjMg/MDAxNTA0MDE3MTYzNDUx.Nxxsizk9xcizTM6gIUnjvnCR1n2iMj9OPHPbZB1tt3Yg.8D03w8j5LDUO_dmvln5igmiftP6dn6fTztXmUq__aUYg.PNG.o_oaill/pic3.png?type=w1")

7.6 국소회귀
우연한 비선형함수들을 적합하는 다른 기법이다. 목표점 x0에서 그 주변의 훈련 관측치들만을 사용하여 적합을 계산하는 것이다. 기억 기반 절차라고도 하는데 그 이유는 최근접이웃과 같이 예측을 계산하고자 할 때마다 모든 훈련 데이터를 필요로 하기 때문이다. 가중치 K를 어떻게 정의하고, 위의 step3에서 선형, 상수 또는 이차회귀를 적합할지 선택해야 한다. 이러한 모든 선택들이 어떠한 차이를 만든다. k개의 최근접이웃 이외의 모든 점은 가중치가 0이다. K개 중에서 X0와 가장 가까운 점은 가장 높은 가중치를 가진다. X0에서 가장 먼 점은 가중치가 0이다. 훈련 포인트들의 xi가 x0에 가장 가까운 일부 s=k/n을 모은다. S은 생성이라고 하는데 생성은 평활 스플라인의 조율 파라미터(람다)와 같은 역할을 하며 비선형적합의 유연성을 제어한다. s값이 작을수록 적합은 더 국소적이고 꾸불할 것이다. 반대로 s값이 아주 크면 훈련 관측치 모두를 사용하여 데이터에 전역적 적합이 될 것이다. 국소회귀는 p(X 변수의 개수)가 3또는 4보다 훨씬 크면 x0에 가까운 훈련 관측치가 일반적으로 매우 적기 때문에 성능이 나쁠 수 있다.(knn도 동일)

![pic4]("http://postfiles15.naver.net/MjAxNzA4MjlfMzkg/MDAxNTA0MDE3MTYzMjI0.ZapW-8CxM3SG3JNNzzqkJXanFkHW4zUzY6Zoyf10jXAg.uruGc7tvMbwr2l1pQpJrEQdYy1f-zD2n0Cm1vkEe2W4g.PNG.o_oaill/pic4.png?type=w1")

7.7 일반화가법모델
일반화가법모델(GAMs)는 가산성은 유지하면서 각 변수의 비선형함수들을 허용하여 표준선형모델을 확장하는 일반적인 체계를 제공한다. 더하는 한 단위를 빌딩블럭이라고 한다. 자연스플라인을 가지고 GAM적합하는 방법과 평활스플라인을 가지고 GAM을 적합하는 방법이 있다. 평활스플라인을 가지고 적합하는 것은 최소제곱이 사용될 수 없기 때문에 GAM을 적합하는 것은 간단하지 않다. 그래서 후방적합으로 알려진 기법을 사용해야 한다. 이 방법은 교대로 각 설명변수에 대한 적합을 다른 변수들은 고정한채 반복하여 업데이트함으로써 다중 설명변수를 포함하는 모델을 적합한다. 이 기법의 장점은 함수를 업데이트할 때마다 단순히 그 변수에 대한 적합 방법을 부분잔차에 적용한다는 것이다. 대부분의 경우 평활 스플라인과 자연 스플라인을 사용하여 얻은 GAMs 사이에 차이가 크지 않다. 
GAMs는 Xj 각각에 비선형함수 fj를 적합할 수 있어 표준적 선형회귀로는 놓치게 될 비선형 관계를 자동적으로 모델링할 수 있다. 이것은 각 변수에 대해 많은 다른 변환을 수동으로 시도해볼 필요가 없다는 것을 말한다. 비선형 적합은 반응변수 Y에 대해 더 정확하게 예측할 가능성이 있다. 이 모델은 가산적이기 때문에 Y에 대한 Xj 각각의 영향을 다른 변수들은 모두 고정하고서 개별적으로 조사할 수 있다. 따라서 추론에 관심이 있다면 GAMs이 제공하는 표현은 유용하다. 변수 터에 대한 함수 fj의 평활도는 자유도를 통해 요약될 수 있다. 
GAMs의 주요 한계는 모델이 가산적이어야 한다는 제한이다. 많은 변수들이 있는 경우 중요한 상호작용을 놓칠 수 있다. 하지만 선형회귀에서와 같이 Xj x Xk 형태의 추가적인 설명변수들을 초함함으로써 수동으로 상호작용 항을 GAMs 모델에 추가할 수 있다.
완전히 일반적인 모델의 경우, 랜덤포리스트와 부스팅과 같은 더 유연한 기법들을 살펴보아야 한다. GAMs는 선형모델과 완전 비모수적 모델 사이에서 절충하는데 유용하다.
GAMs는 Y가 질적인 경우에도 사용될 수 있다. 질적변수X인 경우에 f(x)는 계단함수로 적합된다.
<자연스플라인 가법모델 GAMs>
![pic5]("http://postfiles6.naver.net/MjAxNzA4MjlfMjI1/MDAxNTA0MDE3MTYyOTY4.soivIZqlzGkDcZkj5mgT46ujDFmSnJpFEAPuQPhNSwUg._xrEH1adWdAR_nkbMLk_gKnRplzRc_D4MUWDOExiGH0g.PNG.o_oaill/pic5.png?type=w1")

<평활스플라인 가법모델 GAMs>
![pic6]("http://postfiles16.naver.net/MjAxNzA4MjlfMjI4/MDAxNTA0MDE3MTYyNzUx.KPI3amFmJv6sRthpr4lSmOdwbDkclDE065JofJGCXCEg.KidrUe14GdzPvYRXB863kKmpNcthINPF3JjxECHX2vcg.PNG.o_oaill/pic6.png?type=w1")

<평활스플라인 + 국소회귀 가법모델 GAMs>
![pic7]("http://postfiles15.naver.net/MjAxNzA4MjlfMjg5/MDAxNTA0MDE3MTYyNTQx.vS5haeIFJK5J5o3h75DdoKTlDtyDm0UbP6YvQF8dsZ4g.HvbKbW9CY6RGoP8y2nuTOq0ixHwh68nAoFhF-SNxlNQg.PNG.o_oaill/pic7.png?type=w1")

<국소회귀 가법모델 GAMs>
![pic8]("http://postfiles14.naver.net/MjAxNzA4MjlfMTAw/MDAxNTA0MDE3MTYyMzE1.EgCSJyZe--zav_x-Bj7NxDgwSXQ2yBp1hT3wWU6w1ncg.KJwje4GJ7fmmF7d90UbnasSHSSklzOPUkD6A04k2A9gg.PNG.o_oaill/pic8.png?type=w1"0

<로지스틱 회귀 GAMs>
![pic9]("http://postfiles8.naver.net/MjAxNzA4MjlfMjEw/MDAxNTA0MDE3MTYyMDg1.9ikGhZwWpZO1efwb1WhREl26GOkEu9Ws-lPGGf9TVL0g.QajOkG8u9RnVe9M-ZsG7Y0kIQEa7RnEJDfNzr3ggDw0g.PNG.o_oaill/pic9.png?type=w1")

<로지스틱 회귀 GAMs - year에서 <HS 제외 모델>
![pic10]("http://postfiles1.naver.net/MjAxNzA4MjlfNDAg/MDAxNTA0MDE3MTYxODYx.5LDGr45HL_HoPng2x3w-u53Hu9xaRDkm2nHjGr9Nw2gg.DW7juTNkoNvNVxXrhW-xkeQsKIdklSXAczNPwHK3LPAg.PNG.o_oaill/pic10.png?type=w1")


