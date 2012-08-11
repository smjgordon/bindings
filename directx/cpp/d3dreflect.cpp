#include <windows.h>
#include <d3dcompiler.h>
#include <d3d11.h>


typedef HRESULT (*pfnD3DReflect)(
  LPCVOID pSrcData,
  SIZE_T SrcDataSize,
  REFIID pInterface,
  void **ppReflector);


CRITICAL_SECTION D3DShaderDllLock;
HMODULE D3DShaderDll = NULL;
pfnD3DReflect fnD3DReflect;
EXTERN_C const GUID DECLSPEC_SELECTANY IID_ID3D11ShaderReflection = { 0x0a233719, 0x3960, 0x4578, { 0x9d,  0x7c,  0x20,  0x3b,  0x8b,  0x1d,  0x9c, 0xc1 } };

EXTERN_C const GUID DECLSPEC_SELECTANY IID_IWrappedShaderReflectionType = { 0x7d5c8890, 0x074b, 0x4f1c, { 0xa2, 0xb1, 0x64, 0x42, 0x8a, 0x0c, 0xc0, 0x48 } };
EXTERN_C const GUID DECLSPEC_SELECTANY IID_IWrappedShaderReflectionVariable = { 0xa73ed428, 0xbf7c, 0x4319, { 0x97, 0xed, 0xe1, 0x04, 0xfb, 0xac, 0xe5, 0xa3 } };
EXTERN_C const GUID DECLSPEC_SELECTANY IID_IWrappedShaderReflectionConstantBuffer = { 0xb5dce711, 0x9802, 0x4bc9, { 0x86, 0xff, 0x63, 0x1f, 0xda, 0x61, 0x1d, 0x17 } };
EXTERN_C const GUID DECLSPEC_SELECTANY IID_IWrappedShaderReflection = { 0x02dc06cb, 0xefdc, 0x4ffe, { 0xab, 0x9f, 0x3d, 0x50, 0xa4, 0x81, 0xab, 0xfc } };


class IWrappedShaderReflectionType;
class IWrappedShaderReflectionVariable;
class IWrappedShaderReflectionConstantBuffer;
class IWrappedShaderReflection;


static void BindShaderDLL()
{
	fnD3DReflect = (pfnD3DReflect)GetProcAddress(D3DShaderDll,"D3DReflect");
}


static void LoadShaderDLL()
{
	bool bNeedsBinding = FALSE;
	EnterCriticalSection(&D3DShaderDllLock);
	if (D3DShaderDll == NULL)
	{
		D3DShaderDll = LoadLibrary("D3DCompiler_43.dll");	// june 2010 dx sdk
		bNeedsBinding = (D3DShaderDll != NULL);
	}
	if (bNeedsBinding)
	{
		BindShaderDLL();
	}
	LeaveCriticalSection(&D3DShaderDllLock);
}


DECLARE_INTERFACE_(IWrappedShaderReflectionType, IUnknown)
{
    STDMETHOD(GetDesc)(THIS_ __out D3D11_SHADER_TYPE_DESC *pDesc) PURE;
    
    STDMETHOD_(IWrappedShaderReflectionType*, GetMemberTypeByIndex)(THIS_ __in UINT Index) PURE;
    STDMETHOD_(IWrappedShaderReflectionType*, GetMemberTypeByName)(THIS_ __in LPCSTR Name) PURE;
    STDMETHOD_(LPCSTR, GetMemberTypeName)(THIS_ __in UINT Index) PURE;

    STDMETHOD(IsEqual)(THIS_ __in IWrappedShaderReflectionType* pType) PURE;
    STDMETHOD_(IWrappedShaderReflectionType*, GetSubType)(THIS) PURE;
    STDMETHOD_(IWrappedShaderReflectionType*, GetBaseClass)(THIS) PURE;
    STDMETHOD_(UINT, GetNumInterfaces)(THIS) PURE;
    STDMETHOD_(IWrappedShaderReflectionType*, GetInterfaceByIndex)(THIS_ __in UINT uIndex) PURE;
    STDMETHOD(IsOfType)(THIS_ __in IWrappedShaderReflectionType* pType) PURE;
    STDMETHOD(ImplementsInterface)(THIS_ __in IWrappedShaderReflectionType* pBase) PURE;
};


DECLARE_INTERFACE_(IWrappedShaderReflectionVariable, IUnknown)
{
    STDMETHOD(GetDesc)(THIS_ __out D3D11_SHADER_VARIABLE_DESC *pDesc) PURE;
    
    STDMETHOD_(IWrappedShaderReflectionType*, GetType)(THIS) PURE;
    STDMETHOD_(IWrappedShaderReflectionConstantBuffer*, GetBuffer)(THIS) PURE;

    STDMETHOD_(UINT, GetInterfaceSlot)(THIS_ __in UINT uArrayIndex) PURE;
};


DECLARE_INTERFACE_(IWrappedShaderReflectionConstantBuffer, IUnknown)
{
    STDMETHOD(GetDesc)(THIS_ D3D11_SHADER_BUFFER_DESC *pDesc) PURE;
    
    STDMETHOD_(IWrappedShaderReflectionVariable*, GetVariableByIndex)(THIS_ __in UINT Index) PURE;
    STDMETHOD_(IWrappedShaderReflectionVariable*, GetVariableByName)(THIS_ __in LPCSTR Name) PURE;
};


DECLARE_INTERFACE_(IWrappedShaderReflection, IUnknown)
{
    STDMETHOD(QueryInterface)(THIS_ __in REFIID iid,
                              __out LPVOID *ppv) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    STDMETHOD(GetDesc)(THIS_ __out D3D11_SHADER_DESC *pDesc) PURE;
    
    STDMETHOD_(IWrappedShaderReflectionConstantBuffer*, GetConstantBufferByIndex)(THIS_ __in UINT Index) PURE;
    STDMETHOD_(IWrappedShaderReflectionConstantBuffer*, GetConstantBufferByName)(THIS_ __in LPCSTR Name) PURE;
    
    STDMETHOD(GetResourceBindingDesc)(THIS_ __in UINT ResourceIndex,
                                      __out D3D11_SHADER_INPUT_BIND_DESC *pDesc) PURE;
    
    STDMETHOD(GetInputParameterDesc)(THIS_ __in UINT ParameterIndex,
                                     __out D3D11_SIGNATURE_PARAMETER_DESC *pDesc) PURE;
    STDMETHOD(GetOutputParameterDesc)(THIS_ __in UINT ParameterIndex,
                                      __out D3D11_SIGNATURE_PARAMETER_DESC *pDesc) PURE;
    STDMETHOD(GetPatchConstantParameterDesc)(THIS_ __in UINT ParameterIndex,
                                             __out D3D11_SIGNATURE_PARAMETER_DESC *pDesc) PURE;

    STDMETHOD_(IWrappedShaderReflectionVariable*, GetVariableByName)(THIS_ __in LPCSTR Name) PURE;

    STDMETHOD(GetResourceBindingDescByName)(THIS_ __in LPCSTR Name,
                                            __out D3D11_SHADER_INPUT_BIND_DESC *pDesc) PURE;

    STDMETHOD_(UINT, GetMovInstructionCount)(THIS) PURE;
    STDMETHOD_(UINT, GetMovcInstructionCount)(THIS) PURE;
    STDMETHOD_(UINT, GetConversionInstructionCount)(THIS) PURE;
    STDMETHOD_(UINT, GetBitwiseInstructionCount)(THIS) PURE;
    
    STDMETHOD_(D3D_PRIMITIVE, GetGSInputPrimitive)(THIS) PURE;
    STDMETHOD_(BOOL, IsSampleFrequencyShader)(THIS) PURE;

    STDMETHOD_(UINT, GetNumInterfaceSlots)(THIS) PURE;
    STDMETHOD(GetMinFeatureLevel)(THIS_ __out enum D3D_FEATURE_LEVEL* pLevel) PURE;

    STDMETHOD_(UINT, GetThreadGroupSize)(THIS_
                                         __out_opt UINT* pSizeX,
                                         __out_opt UINT* pSizeY,
                                         __out_opt UINT* pSizeZ) PURE;
};


class WrappedShaderReflectionType : public IWrappedShaderReflectionType
{
private:
	ULONG refCount;
	ID3D11ShaderReflectionType* realInterface;
	IWrappedShaderReflection* owner;

public:
	WrappedShaderReflectionType(ID3D11ShaderReflectionType* inRealInterface, IWrappedShaderReflection* InOwner)
		:refCount(1)
		,realInterface(inRealInterface)
		,owner(InOwner)
	{
		owner->AddRef();
	}

	STDMETHOD_(UINT, IsWrapped)(THIS_)
	{
		return TRUE;
	}
	STDMETHOD(GetDesc)(THIS_ __out D3D11_SHADER_TYPE_DESC *pDesc)
	{
		return realInterface->GetDesc(pDesc);
	}
    STDMETHOD_(WrappedShaderReflectionType*, GetMemberTypeByIndex)(THIS_ __in UINT Index)
    {
    	ID3D11ShaderReflectionType* ptr = realInterface->GetMemberTypeByIndex(Index);
    	if (ptr)
		{
			return new WrappedShaderReflectionType(ptr, owner);
		}
		return NULL;
	}
    STDMETHOD_(IWrappedShaderReflectionType*, GetMemberTypeByName)(THIS_ __in LPCSTR Name)
    {
    	ID3D11ShaderReflectionType* ptr = realInterface->GetMemberTypeByName(Name);
    	if (ptr)
		{
			return new WrappedShaderReflectionType(ptr, owner);
		}
		return NULL;
	}
    STDMETHOD_(LPCSTR, GetMemberTypeName)(THIS_ __in UINT Index)
    {
    	return realInterface->GetMemberTypeName(Index);
	}
    STDMETHOD(IsEqual)(THIS_ __in IWrappedShaderReflectionType* pType)
    {
    	WrappedShaderReflectionType* other = static_cast<WrappedShaderReflectionType*>(pType);
		return realInterface->IsEqual(other->realInterface);
	}
    STDMETHOD_(IWrappedShaderReflectionType*, GetSubType)(THIS)
    {
    	ID3D11ShaderReflectionType* ptr = realInterface->GetSubType();
    	if (ptr)
		{
			return new WrappedShaderReflectionType(ptr, owner);
		}
		return NULL;    	
	}
    STDMETHOD_(IWrappedShaderReflectionType*, GetBaseClass)(THIS)
    {
    	ID3D11ShaderReflectionType* ptr = realInterface->GetBaseClass();
    	if (ptr)
		{
			return new WrappedShaderReflectionType(ptr, owner);
		}
		return NULL;
	}
    STDMETHOD_(UINT, GetNumInterfaces)(THIS)
    {
    	return realInterface->GetNumInterfaces();
	}
    STDMETHOD_(IWrappedShaderReflectionType*, GetInterfaceByIndex)(THIS_ __in UINT uIndex)
    {
    	ID3D11ShaderReflectionType* ptr = realInterface->GetInterfaceByIndex(uIndex);
    	if (ptr)
		{
			return new WrappedShaderReflectionType(ptr, owner);
		}
		return NULL;
	}
    STDMETHOD(IsOfType)(THIS_ __in IWrappedShaderReflectionType* pType)
    {
    	WrappedShaderReflectionType* other = static_cast<WrappedShaderReflectionType*>(pType);
    	return realInterface->IsOfType(other->realInterface);
	}
    STDMETHOD(ImplementsInterface)(THIS_ __in IWrappedShaderReflectionType* pBase)
    {
    	WrappedShaderReflectionType* other = static_cast<WrappedShaderReflectionType*>(pBase);
    	return realInterface->ImplementsInterface(other->realInterface);
	}
	

	STDMETHOD(QueryInterface)(REFIID riid, void **ppvObject)
	{
		if (IsEqualGUID(riid, IID_IWrappedShaderReflectionType))
		{
			AddRef();
			*ppvObject = static_cast<IWrappedShaderReflectionType*>(this);
			return S_OK;
		}
		if (IsEqualGUID(riid, IID_IUnknown))
		{
			AddRef();
			*ppvObject = static_cast<IUnknown*>(this);
			return S_OK;
		}
		*ppvObject = NULL;
		return E_FAIL;
	}	
	STDMETHOD_(ULONG, AddRef)()
	{
		return InterlockedIncrement(&refCount);
	}
	STDMETHOD_(ULONG, Release)()
	{
		ULONG returnValue = InterlockedDecrement(&refCount);
		if( returnValue == 0 )
		{
			owner->Release();
			delete this;
		}
		return returnValue;
	}
};


class WrappedShaderReflectionVariable : public IWrappedShaderReflectionVariable
{
private:
	ULONG refCount;
	ID3D11ShaderReflectionVariable* realInterface;
	IWrappedShaderReflection* owner;

public:
	WrappedShaderReflectionVariable(ID3D11ShaderReflectionVariable* inRealInterface, IWrappedShaderReflection* inOwner)
		:refCount(1)
		,realInterface(inRealInterface)
		,owner(inOwner)
	{
		owner->AddRef();
	}	

	STDMETHOD_(UINT, IsWrapped)(THIS_)
	{
		return TRUE;
	}		
    STDMETHOD(GetDesc)(THIS_ __out D3D11_SHADER_VARIABLE_DESC *pDesc)
    {
    	return realInterface->GetDesc(pDesc);
    }
    STDMETHOD_(IWrappedShaderReflectionType*, GetType)(THIS)
    {
    	ID3D11ShaderReflectionType* ptr = realInterface->GetType();
    	if (ptr)
		{
			return new WrappedShaderReflectionType(ptr, owner);
		}
		return NULL;    	
    }
    STDMETHOD_(IWrappedShaderReflectionConstantBuffer*, GetBuffer)(THIS);
    STDMETHOD_(UINT, GetInterfaceSlot)(THIS_ __in UINT uArrayIndex)
    {
    	return realInterface->GetInterfaceSlot(uArrayIndex);
    }

	STDMETHOD(QueryInterface)(REFIID riid, void **ppvObject)
	{
		if (IsEqualGUID(riid, IID_IWrappedShaderReflectionVariable))
		{
			AddRef();
			*ppvObject = static_cast<IWrappedShaderReflectionVariable*>(this);
			return S_OK;
		}
		if (IsEqualGUID(riid, IID_IUnknown))
		{
			AddRef();
			*ppvObject = static_cast<IUnknown*>(this);
			return S_OK;
		}		
		*ppvObject = NULL;
		return E_FAIL;
	}	
	STDMETHOD_(ULONG, AddRef)()
	{
		return InterlockedIncrement(&refCount);
	}
	STDMETHOD_(ULONG, Release)()
	{
		ULONG returnValue = InterlockedDecrement(&refCount);
		if( returnValue == 0 )
		{
			owner->Release();
			delete this;
		}
		return returnValue;
	}
};


class WrappedShaderReflectionConstantBuffer : public IWrappedShaderReflectionConstantBuffer
{
private:
	ULONG refCount;
	ID3D11ShaderReflectionConstantBuffer* realInterface;
	IWrappedShaderReflection* owner;

public:
	WrappedShaderReflectionConstantBuffer(ID3D11ShaderReflectionConstantBuffer* inRealInterface, IWrappedShaderReflection* inOwner)
		:refCount(1)
		,realInterface(inRealInterface)
		,owner(inOwner)
	{
		owner->AddRef();
	}

	STDMETHOD_(UINT, IsWrapped)(THIS_)
	{
		return TRUE;
	}
    STDMETHOD(GetDesc)(THIS_ D3D11_SHADER_BUFFER_DESC *pDesc)
    {
    	return realInterface->GetDesc(pDesc);
    }
    STDMETHOD_(IWrappedShaderReflectionVariable*, GetVariableByIndex)(THIS_ __in UINT Index)
    {
    	ID3D11ShaderReflectionVariable* ptr = realInterface->GetVariableByIndex(Index);
    	if (ptr)
		{
			return new WrappedShaderReflectionVariable(ptr, owner);
		}
		return NULL;  
    }
    STDMETHOD_(IWrappedShaderReflectionVariable*, GetVariableByName)(THIS_ __in LPCSTR Name)
    {
    	ID3D11ShaderReflectionVariable* ptr = realInterface->GetVariableByName(Name);
    	if (ptr)
		{
			return new WrappedShaderReflectionVariable(ptr, owner);
		}
		return NULL;
    }

	STDMETHOD(QueryInterface)(REFIID riid, void **ppvObject)
	{
		if (IsEqualGUID(riid, IID_IWrappedShaderReflectionConstantBuffer))
		{
			AddRef();
			*ppvObject = static_cast<IWrappedShaderReflectionConstantBuffer*>(this);
			return S_OK;
		}
		if (IsEqualGUID(riid, IID_IUnknown))
		{
			AddRef();
			*ppvObject = static_cast<IUnknown*>(this);
			return S_OK;
		}
		*ppvObject = NULL;
		return E_FAIL;
	}	
	STDMETHOD_(ULONG, AddRef)()
	{
		return InterlockedIncrement(&refCount);
	}
	STDMETHOD_(ULONG, Release)()
	{
		ULONG returnValue = InterlockedDecrement(&refCount);
		if( returnValue == 0 )
		{
			owner->Release();
			delete this;
		}
		return returnValue;
	}
};


class WrappedShaderReflection : public IWrappedShaderReflection
{
private:
	ID3D11ShaderReflection* realInterface;
	
	
public:
	WrappedShaderReflection(ID3D11ShaderReflection* inRealInterface)
		:realInterface(inRealInterface)
	{
	}
	
	STDMETHOD_(UINT, IsWrapped)(THIS_)
	{
		return TRUE;
	}	
    STDMETHOD(GetDesc)(THIS_ __out D3D11_SHADER_DESC *pDesc)
    {
    	return realInterface->GetDesc(pDesc);
	}
    STDMETHOD_(IWrappedShaderReflectionConstantBuffer*, GetConstantBufferByIndex)(THIS_ __in UINT Index)
    {
    	ID3D11ShaderReflectionConstantBuffer* ptr = realInterface->GetConstantBufferByIndex(Index);
    	if (ptr)
		{
			return new WrappedShaderReflectionConstantBuffer(ptr, this);
		}
		return NULL; 
	}
    STDMETHOD_(IWrappedShaderReflectionConstantBuffer*, GetConstantBufferByName)(THIS_ __in LPCSTR Name)
    {
    	ID3D11ShaderReflectionConstantBuffer* ptr = realInterface->GetConstantBufferByName(Name);
    	if (ptr)
		{
			return new WrappedShaderReflectionConstantBuffer(ptr, this);
		}
		return NULL;    	
	}
    STDMETHOD(GetResourceBindingDesc)(THIS_ __in UINT ResourceIndex,
                                      __out D3D11_SHADER_INPUT_BIND_DESC *pDesc)
	{
		return realInterface->GetResourceBindingDesc(ResourceIndex, pDesc);
	}
    STDMETHOD(GetInputParameterDesc)(THIS_ __in UINT ParameterIndex,
                                     __out D3D11_SIGNATURE_PARAMETER_DESC *pDesc)
	{
		return realInterface->GetInputParameterDesc(ParameterIndex, pDesc);
	}
    STDMETHOD(GetOutputParameterDesc)(THIS_ __in UINT ParameterIndex,
                                      __out D3D11_SIGNATURE_PARAMETER_DESC *pDesc) 
	{
		return realInterface->GetOutputParameterDesc(ParameterIndex, pDesc);
	}
    STDMETHOD(GetPatchConstantParameterDesc)(THIS_ __in UINT ParameterIndex,
	                                             __out D3D11_SIGNATURE_PARAMETER_DESC *pDesc)
	{
		return realInterface->GetPatchConstantParameterDesc(ParameterIndex, pDesc);
	}
    STDMETHOD_(IWrappedShaderReflectionVariable*, GetVariableByName)(THIS_ __in LPCSTR Name)
    {
    	ID3D11ShaderReflectionVariable* ptr = realInterface->GetVariableByName(Name);
    	if (ptr)
		{
			return new WrappedShaderReflectionVariable(ptr, this);
		}
		return NULL;
	}
    STDMETHOD(GetResourceBindingDescByName)(THIS_ __in LPCSTR Name,
                                            __out D3D11_SHADER_INPUT_BIND_DESC *pDesc)
    {
    	return realInterface->GetResourceBindingDescByName(Name, pDesc);
	}
    STDMETHOD_(UINT, GetMovInstructionCount)(THIS)
    {
    	return realInterface->GetMovInstructionCount();
	}
    STDMETHOD_(UINT, GetMovcInstructionCount)(THIS)
    {
    	return realInterface->GetMovcInstructionCount();
	}
    STDMETHOD_(UINT, GetConversionInstructionCount)(THIS)
    {
    	return realInterface->GetConversionInstructionCount();
	}
    STDMETHOD_(UINT, GetBitwiseInstructionCount)(THIS)
    {
    	return realInterface->GetBitwiseInstructionCount();
	}
    STDMETHOD_(D3D_PRIMITIVE, GetGSInputPrimitive)(THIS)
    {
    	return realInterface->GetGSInputPrimitive();
	}
    STDMETHOD_(BOOL, IsSampleFrequencyShader)(THIS)
    {
    	return realInterface->IsSampleFrequencyShader();
	}
    STDMETHOD_(UINT, GetNumInterfaceSlots)(THIS)
    {
    	return realInterface->GetNumInterfaceSlots();
	}
    STDMETHOD(GetMinFeatureLevel)(THIS_ __out enum D3D_FEATURE_LEVEL* pLevel)
    {
    	return realInterface->GetMinFeatureLevel(pLevel);
	}
    STDMETHOD_(UINT, GetThreadGroupSize)(THIS_
                                         __out_opt UINT* pSizeX,
                                         __out_opt UINT* pSizeY,
                                         __out_opt UINT* pSizeZ)
	{
		return realInterface->GetThreadGroupSize(pSizeX, pSizeY, pSizeZ);
	}
                                         	
	STDMETHOD(QueryInterface)(REFIID riid, void **ppvObject)
	{
		if (IsEqualGUID(riid, IID_IWrappedShaderReflection))
		{
			AddRef();
			*ppvObject = static_cast<IWrappedShaderReflection*>(this);
			return S_OK;
		}
		if (IsEqualGUID(riid, IID_IUnknown))
		{
			AddRef();
			*ppvObject = static_cast<IUnknown*>(this);
			return S_OK;
		}
		*ppvObject = NULL;
		return E_FAIL;
	}	
	STDMETHOD_(ULONG, AddRef)()
	{
		return realInterface->AddRef();
	}
	STDMETHOD_(ULONG, Release)()
	{
		ULONG returnValue = realInterface->Release();
		if( returnValue == 0 )
		{
			delete this;
		}
		return returnValue;
	}
};


IWrappedShaderReflectionConstantBuffer* WrappedShaderReflectionVariable::GetBuffer()
{
	ID3D11ShaderReflectionConstantBuffer* ptr = realInterface->GetBuffer();
	if (ptr)
	{
		return new WrappedShaderReflectionConstantBuffer(ptr, owner);
	}
	return NULL; 
}


extern "C" __declspec(dllexport) HRESULT __stdcall D3DReflectCOM(
  __in   LPCVOID pSrcData,
  __in   SIZE_T SrcDataSize,
  __in   REFIID pInterface,
  __out  void **ppReflector
)
{
    *ppReflector = NULL;
	HRESULT rslt = E_FAIL;
	if (!fnD3DReflect)
	{
		LoadShaderDLL();
	}
	if (fnD3DReflect)
	{
		if (IsEqualGUID(pInterface, IID_IWrappedShaderReflection))
		{
			ID3D11ShaderReflection* realReflectInterface = NULL;
			IWrappedShaderReflection* wrappedReflectInterface = NULL;
			HRESULT realRslt = (*fnD3DReflect)(pSrcData, SrcDataSize, IID_ID3D11ShaderReflection, (void**)&realReflectInterface);
			if (realReflectInterface != NULL)
			{
				wrappedReflectInterface = new WrappedShaderReflection(realReflectInterface);
			}
			if (wrappedReflectInterface)
			{
                *ppReflector = wrappedReflectInterface;
				rslt = realRslt;
			}
			else
			{
				if (realReflectInterface)
				{
					realReflectInterface->Release();
					realReflectInterface = NULL;
				}			
			}
		}
	}
	return rslt;
}


BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
	switch (fdwReason)
	{
		case DLL_PROCESS_ATTACH:
			InitializeCriticalSection(&D3DShaderDllLock);
			break;
		case DLL_PROCESS_DETACH:
			DeleteCriticalSection(&D3DShaderDllLock);
			break;
	}
	return TRUE;
}

