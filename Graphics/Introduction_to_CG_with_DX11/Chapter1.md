# Chapter 1. 환경 설정

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

### [ C++ 문법]

- `unique_ptr` 
  - smart pointer, 자동으로 메모리를 해제해줌
  - `make_unique`를 통해서 생성

### [ union을 이용한 Vec4 구현 ]

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
