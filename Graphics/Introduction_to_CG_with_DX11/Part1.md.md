# Part 1. Basic Concept of Rendering

## Chapter 1. 환경 설정

- IDE: Visual Studio 2022

- Package Manager: vcpkg

- IMGUI

- DirectX 11

  > DirectX 11의 구체적인 사용법은 Part 2에서 자세히 다룰 예정

  - `Map()`, `Unmap()` : **CPU의 Memory-->**와  **GPU의 Memory** 를 대응시키고, 해제하는 것이 가능함

    > 일반적으로 그래픽스에서 **Bottle Neck(병목)** 은 CPU에서 GPU로 데이터를 복사하는 구간에서 발생함

    ```c++
    // @실습용 코드에서 발췌
    // @Project : 01_DX11InitAndlmGui
    // @File : Example.h
    
    // Update textue buffer
    D3D11_MAPPED_SUBRESOURCE ms;
    deviceContext->Map(canvasTexture, NULL, D3D11_MAP_WRITE_DISCARD, NULL, &ms);
    memcpy(ms.pData, pixels.data(), pixels.size() * sizeof(Vec4));
    deviceContext->Unmap(canvasTexture, NULL);
    ```

  - `<d3dcompiler.h>` : `VS.hlsl`(Vertex shader), `PS.hlsl`(Pixel shader) 컴파일시 사용

    - .hlsl : high-level shader language
    - Vertex shader와 Pixel shader의 차이는 ?

---

##### [ C++ 문법]

- `unique_ptr` 
  - smart pointer, 자동으로 메모리를 해제해줌
  - `make_unique`를 통해서 생성

##### [union을 이용한 Vec4 구현]

> 특정 변수명, 배열 모두 접근 가능하도록 구현

```c++
#include <iostream>

struct Vec4
{
    union
    {
        struct
        {
            float r, g, b, a;
        };
   		float elements[4];
    };
};

int main() {
    Vec4 vec;

    vec.r = 0.1f; // <- r, g, b, a로 사용 가능
    vec.g = 0.2f;
    vec.b = 0.3f;
    vec.a = 0.4f;

    std::cout << "R: " << vec.r << " G: " << vec.g << " B: " << vec.b << " A: " << vec.a << std::endl;



    // 배열로 사용 가능
    for (size_t i = 0; i < 4; ++i) {
        std::cout << "Element " << i << ": " << vec.elements[i] <<         std::endl;
}

return 0;
}
```

## Chapter 2. 블룸 효과 만들기

## Chapter 3. 광추적기 만들기

### 벡터 (Vector)

- 한 개의 숫자 : Scalar &larr;&rarr;  숫자의 묶음 : Vector

- 좌표계(Coordinate system) : 원점 설정등 필요에 따라 사용자가 정의할 수 있음

- 벡터의 표기 
  $$
  \vec{a}
  $$

- 벡터의 요소

  > salar는 방향을 나타낼 수 없고 거리만 나타낼 수 있음

  - 방향(direction)

  - 거리(distance) or 크기(magnitude)
    $$
    \vert \vec{a} \vert
    $$

    > 피타고라스의 정리로 구할 수 있음

- 단위벡터(unit vector) : 크기가 1인 벡터
  $$
  \vec{a}\over\vert\vec{a}\vert
  $$

  > 거리에 대한 정보를 없애고 방향만 표기하고 싶을 때 단위벡터로 변환하여 사용

- 벡터의 연산

  - 벡터 차

  - 벡터 합

  - 벡터 곱(Product)

    - Dot product, scalar product (결과값이 스칼라)
      $$
      \vec{a} \cdot \vec{b}
      $$

      > [기하학적 의미]
      >
      > 벡터b가 단위 벡터일 경우, 
      >
      > 벡터a를 벡터b 위로 투영(project)을 시키고 투영된 길이를 의미(두 벡터 사의 각도가 크면 작아지고, 각도가 작으면 커짐)
      
    - Cross product, vector product (결과값이 벡터)
      $$
      \vec{a} \times \vec{b} \\
      이때, \\
      \vec{a} \cdot (\vec{a} \times \vec{b}) = 0 \\
      \vec{b} \cdot (\vec{a} \times \vec{b}) = 0
      $$
      
      > directX 에서는 전통적으로 왼손 좌표계를 사용
      >
      > > [기하학적 의미]
      > >
      > > 외적의 절대값은 두 벡터 사이에 그려지는 삼각형의 넚이 * 2 (즉, 평행사변형의 넓이)

- 연산을 위한 Library (GLM)

  - 현재 강의에서는 glm(OpenGL Mathmatics) 사용

  - directX내부에도 `<DirectXMath.h>`가 존재함

    > 다루기 어려움
    >
    > **SIMD가속**에 맞춰져 있음
    >
    > > CPU의 병렬 컴퓨팅을 통한 처리

  - 설치 : `vcpkg install glm:x64-windows`

  - `glm::to_string()` : 벡터 출력시 용이

  - `glm::normalize` : 유닛 벡터로 만들 때 사용

    > 길이가 0.0인 벡터를 유닛 벡터로 만드려고 시도하면 오류

  - `glm::dvec3` : double형 벡터

  - 보충 :

    `glm::length(c)` : 벡터의 크기(길이)

    `(b-a).length()` : 벡터 원소의 개수 = 배열의 길이

### 이미지 좌표계 (스크린 좌표계)

- 좌측 상단이 원점(0,0)
- 우측 하단이 메모리상의 마지막 픽셀(width - 1, height -1)


## Reference

https://en.wikipedia.org/wiki/Relative_luminance

https://darkpgmr.tistory.com/78

https://ko.wikipedia.org/wiki/SIMD

https://cadxfem.org/inf/Fast%20MinimumStorage%20RayTriangle%20Intersection.pdf

https://darkpgmr.tistory.com/117

https://codeonwort.tistory.com/360

https://lifeisforu.tistory.com/386

https://www.youtube.com/watch?v=9h9eZWR5vGo&t=9s

part2 회전행렬

https://www.youtube.com/watch?v=wArGifkRD2A
