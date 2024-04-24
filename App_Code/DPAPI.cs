using System;
using System.Runtime.InteropServices;
using System.Text;
using System.EnterpriseServices;
using System.Configuration;

[assembly: ApplicationName("DPAPI")]
[assembly: Description("Data Protection")]
[assembly: ApplicationActivation(ActivationOption.Server)]
[assembly: ApplicationAccessControl(false,AccessChecksLevel = AccessChecksLevelOption.ApplicationComponent)]

namespace AISProtectData
{
	[GuidAttribute("E20DC5B1-EAAF-4789-A996-1DC93CFA285F")]
    public class DPAPI : ServicedComponent
	{
		#region Constants for flags
		
		// Flags for CRYPTPROTECT_PROMPTSTRUCT
		public const int PromptOnProtect = 0x2;
		public const int PromptOnUnprotect = 0x1;

		// Flags for CryptProtectData and CryptUnprotectData
		public const int UIForbidden = 0x1;
		public const int LocalMachine = 0x4;
		public const int PromptStrong = 0x08;
		public const int Audit = 0x10;
		public const int VerifyProtection = 0x40;

		public const int CredSync = 0x8;
		public const int NoRecovery = 0x20;

/// <summary>
/// 
/// </summary>
		public enum CipherFormat 
		{
			  Base64
			, Binary 
		}

		#endregion Win32 Enums

		internal class PInvoke
		{
			static public IntPtr NullPtr = ((IntPtr)((int)(0)));

			#region Win32 struct declaration

			[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
			public struct DATA_BLOB 
			{
				public int		cbData;	 // count of bytes
				public IntPtr	pbData;	 // pointer to block of data bytes
			}

			[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
			public struct CRYPTPROTECT_PROMPTSTRUCT 
			{
	  			public int		cbSize;			
				public int		dwPromptFlags;  
				public IntPtr	hwndApp;		
				public string	szPrompt;		
			}

			#endregion structs


			#region Win32 function declarations
			
			//
			// CryptProtectData		
			//
			[DllImport("crypt32", CharSet=System.Runtime.InteropServices.CharSet.Unicode, SetLastError=true, ExactSpelling=true)]
			public static extern bool CryptProtectData
			(
				  ref DATA_BLOB dataIn
				, string szDataDescr
				, ref DATA_BLOB optionalEntropy
				, IntPtr pvReserved
				, ref	CRYPTPROTECT_PROMPTSTRUCT pPromptStruct
				, int	dwFlags
				, ref	DATA_BLOB pDataOut
			);

			//
			// CryptUnprotectData
			//
			[DllImport("crypt32", CharSet=System.Runtime.InteropServices.CharSet.Unicode, SetLastError=true, ExactSpelling=true)]
			public static extern bool CryptUnprotectData
			(
				
				ref DATA_BLOB dataIn
				, StringBuilder ppszDataDescr
				,  ref DATA_BLOB optionalEntropy
				, IntPtr pvReserved
				, ref CRYPTPROTECT_PROMPTSTRUCT pPromptStruct
				, int dwFlags
				, ref DATA_BLOB pDataOut
			);
#region FreeLocal Header

			[DllImport("kernel32")]
			public static extern IntPtr LocalFree
			(
				
				
			
				IntPtr hMem
			);
			#endregion FreeLocal Header

	
			#endregion Win32
		}
/// <summary>
/// 
/// </summary>
/// <param name="p_clearText"></param>
/// <param name="p_entropy"></param>
/// <returns></returns>
/// 
        public string Encrypt(string message)
        {
            return ProtectData (message);
        }
        public string Decrypt(string message)
        {
            return UnProtectData(message);
        }
		public static string ProtectData (string p_clearText)
		{
            return protectData(p_clearText, "AISProtectData", DateTime.Now.ToString(), UIForbidden, CipherFormat.Base64);
		}
/// <summary>
/// 
/// </summary>
/// <param name="p_clearText"></param>
/// <param name="p_entropy"></param>
/// <param name="p_description"></param>
/// <param name="p_flags"></param>
/// <param name="p_format"></param>
/// <returns></returns>
		public static string ProtectData (string p_clearText ,string p_entropy, string p_description, int p_flags
						   , CipherFormat p_format)  
		{
			return protectData (p_clearText,p_entropy, p_description, p_flags, p_format) ;
		}



		private static string protectData (string p_clearText ,string p_entropy, string	p_description, int p_flags
						   , CipherFormat p_format) 
		{
			// Clear text comes in
			// Ciphertext comes out

			// Callling function needs to check for null
			// return value which indicates failure
			string retval		= null ;
			byte[] cipherText	= null;
			byte[] dataIn       = null ;
            byte[] entropy      = null ;

			PInvoke.DATA_BLOB				  blobIn        ;
            PInvoke.DATA_BLOB                 blobEntropy   ;
			PInvoke.DATA_BLOB				  blobOut       ;
			PInvoke.CRYPTPROTECT_PROMPTSTRUCT promptStruct  ; 

		
			try 
			{

				
				if (p_clearText != null && p_clearText.Length > 0) 
				{
					// Convert clear text into unicode byte array
					dataIn = Encoding.Unicode.GetBytes(p_clearText) ;
				}
				else
				{
					return retval ;
				}
                if (p_entropy != null && p_entropy.Length > 0) 
                {
                    // Convert clear text into unicode byte array
                    entropy = Encoding.Unicode.GetBytes(p_entropy) ;
                }
                else
                {
                    return retval ;
                }




			

				// Populate inbound DATA_BLOB structure
				blobIn = new PInvoke.DATA_BLOB() ;
				blobIn.cbData = dataIn.Length  ;
				blobIn.pbData = Marshal.AllocHGlobal(blobIn.cbData) ;
				Marshal.Copy(dataIn,0, blobIn.pbData, blobIn.cbData);

                blobEntropy =new PInvoke.DATA_BLOB();
                blobEntropy.cbData = entropy.Length ;
                blobEntropy.pbData =Marshal.AllocHGlobal(blobEntropy.cbData);
                Marshal.Copy(entropy,0,blobEntropy.pbData,blobEntropy.cbData );


				// Populate Prompt Struct
				promptStruct = new PInvoke.CRYPTPROTECT_PROMPTSTRUCT() ;
				promptStruct.cbSize = Marshal.SizeOf(typeof(PInvoke.CRYPTPROTECT_PROMPTSTRUCT));
				promptStruct.dwPromptFlags = 0;
				promptStruct.hwndApp = PInvoke.NullPtr;
				promptStruct.szPrompt = null;

				// Create outbound DATA_BLOB structure
				 blobOut = new PInvoke.DATA_BLOB() ;
			}
			catch
			{
				return retval ;
			}

			try
			{
				// All the structs need to be passed with the ref keyword
				if (PInvoke.CryptProtectData(ref blobIn
					                       , p_description
									       , ref blobEntropy
										   , PInvoke.NullPtr
										   , ref promptStruct
										   , p_flags
										   , ref blobOut)  ) 

				{
					// If call was sucessful, cbData contains the 
					// number of bytes in the ciphertext. 
					// Since this is the number of bytes we are getting back
					// use this to set the lenght of our array
					cipherText =  new byte[blobOut.cbData];

					// Copy the memory from the blob to our array
					Marshal.Copy (blobOut.pbData, cipherText, 0,	blobOut.cbData);

				}  // if CryptProtectData

			}  // try
			finally
			{
				// Free the memory assosicated with the buffer
				PInvoke.LocalFree (blobOut.pbData) ;
			}  // finally

			// If we got something, convert it to base64
			// else we will just leave retVal as null
			if (cipherText != null) 
			{
				retval =  Convert.ToBase64String(cipherText) ;
			}
	
			return retval;
		}   //ProtectData

		public static string UnProtectData(string p_cipherText) 
		{
			if (ConfigurationManager.AppSettings["DBEncryption"] != "1")
            		{
                		return p_cipherText;
            		}
            string p_entropy = "AISProtectData";
			string retval		= null ;
			byte[] clearText	= null ;
			byte[] dataIn	    = null ;
            byte[] entropy      = null ;

			PInvoke.DATA_BLOB				  blobIn    ;
			PInvoke.DATA_BLOB                 blobOut  ;
            PInvoke.DATA_BLOB                 blobEntropy;
			PInvoke.CRYPTPROTECT_PROMPTSTRUCT promptStruct		; 

			try 
			{
				// Make sure arg actually contains data.
				// We could leave this to the try/catch but 
				// since exception are expensive, let's try to
				// shortcircut the error
				if (p_cipherText != null && p_cipherText.Length > 0) 
				{
					// Convert ciphertext out of Base64 into byte array
					dataIn = Convert.FromBase64String (p_cipherText);
				}
					// Otherwise just return null
				else
				{
					return retval ;
				}

                if (p_entropy != null && p_entropy.Length > 0) 
                {
                    // Convert ciphertext out of Base64 into byte array
                    //entropy = Convert.FromBase64String (p_entropy);
                    entropy =System.Text.Encoding.Unicode.GetBytes(p_entropy);
                }
                    // Otherwise just return null
                else
                {
                    return retval ;
                }



				// Populate inbound DATA_BLOB structure
				blobIn = new PInvoke.DATA_BLOB ()  ;
				blobIn.cbData = dataIn.Length ;
				blobIn.pbData = Marshal.AllocHGlobal(blobIn.cbData)	;
				Marshal.Copy (dataIn, 0, blobIn.pbData, blobIn.cbData) ; 

                blobEntropy =new PInvoke.DATA_BLOB();
                blobEntropy.cbData = entropy.Length ;
                blobEntropy.pbData =Marshal.AllocHGlobal(blobEntropy.cbData);
                Marshal.Copy(entropy,0,blobEntropy.pbData,blobEntropy.cbData );






				// Populate Prompt Struct
				promptStruct = new PInvoke.CRYPTPROTECT_PROMPTSTRUCT() ;
				promptStruct.cbSize = Marshal.SizeOf(typeof(PInvoke.CRYPTPROTECT_PROMPTSTRUCT));
				promptStruct.dwPromptFlags = 0;
				promptStruct.hwndApp = PInvoke.NullPtr;
				promptStruct.szPrompt = null;


				// Create outbound DATA_BLOB structure
				blobOut = new PInvoke.DATA_BLOB() ;
			}
			catch
			{
				return retval;
			}

			// New try block so we can free any memory used by 
			try
			{
				// All the structs need to be passed with the ref keyword
				if (PInvoke.CryptUnprotectData(ref blobIn
					, null
					,  ref blobEntropy
					, PInvoke.NullPtr
					, ref promptStruct
					, UIForbidden | VerifyProtection
					, ref blobOut)  ) 
				{
					// If call was sucessful, cbData contains the 
					// number of bytes in the clearText. 
					// Since this is the number of bytes we are getting back
					// use this to set the lenght of our array
					clearText =  new byte[blobOut.cbData];

					// Copy the memory from the blob to our array
					Marshal.Copy (blobOut.pbData, clearText, 0,	blobOut.cbData);

				}  // CryptUnprotectData
			} // try
			finally
			{
				// Free the memory assosicated with the buffer
				PInvoke.LocalFree (blobOut.pbData)   ;
			}  // finally

			// If we got something, convert it to unicode
			// else we will just leave retVal as null
			if (clearText != null) 
			{
				retval =  Encoding.Unicode.GetString(clearText) ;
			}

			return retval ;
		}   // UnProtectData
	}  //DPAPI
}  
