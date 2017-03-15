package com.itko.lisa.ext.sabre.step.edifact;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.ByteBuffer;

public class SabreUtils
{
    static String DOUBLELINEBREAK = "\\r\\n\\r\\n";
    static String LINESEPARATOR = System.getProperty("line.separator");
    
    /*-----------------------------------------------------------------------*/
    /*                          int2ByteArray()                              */
    /*-----------------------------------------------------------------------*/
    /**
     * Converts an integer to a byte array 
     * 
     * @param int integer value to convert into a byte array
     * @return byte array of <b>intValue</b>
     */
    public static byte[] int2ByteArray(int intValue)
    {
        ByteBuffer bb = ByteBuffer.allocate(4); 
        bb.putInt(intValue); 
        return bb.array();    
    }

    /*-----------------------------------------------------------------------*/
    /*                          short2ByteArray()                            */
    /*-----------------------------------------------------------------------*/
    /**
     * Converts an short to a byte array 
     * 
     * @param short integer value to convert into a byte array
     * @return byte array of <b>shortValue</b>
     */
    public static byte[] short2ByteArray(short shortValue)
    {
        ByteBuffer bb = ByteBuffer.allocate(2); 
        bb.putShort(shortValue); 
        return bb.array();    
    }

    /*-----------------------------------------------------------------------*/
    /*                          byteArray2Int()                              */
    /*-----------------------------------------------------------------------*/
    /**
     * Converts a byte array to an Integer. 
     * 
     * @param binaryBytes is the character field data in a byte array
     * @return the integer value of the <b>binaryBytes</b>
     */
    public static int byteArray2Int(byte[] bytes)
    {
        return new BigInteger(bytes).intValue();
    }
    
    /*-----------------------------------------------------------------------*/
    /*                              catBytes()                               */
    /*-----------------------------------------------------------------------*/
    /**
     * This method concactenates 2 byte arrays into a new single byte array
     * 
     * @param aBytes
     * @param bBytes
     * @return new byte[]
     */
    
    public static byte[] catBytes(byte[] aBytes, byte[] bBytes)
    {
        ByteArrayOutputStream byteArrayOS = new ByteArrayOutputStream();
        byteArrayOS.write(aBytes, 0, aBytes.length);
        byteArrayOS.write(bBytes, 0, bBytes.length);

        return byteArrayOS.toByteArray();
    }
    
    
    /*-----------------------------------------------------------------------*/
    /*                           byteArrayToHexString()                      */
    /*-----------------------------------------------------------------------*/
    /**
     * @param rawBytes
     *            array of bytes
     * 
     * @return String of bytes in hex form
     */
    public static String byteArrayToHexString(byte[] rawBytes) 
    {
        StringBuffer sb = new StringBuffer();
        String s;

        for (byte b: rawBytes)
        {
            s = Integer.toHexString((int)b & 0xff);

            if (s.length() == 1)
                sb.append("0");

            sb.append(s);
        }
        return  sb.toString();    
    }
    
    /*-----------------------------------------------------------------------*/
    /*                     byteArrayToHexStringFormatted()                   */
    /*-----------------------------------------------------------------------*/
    /**
     * @param rawBytes
     *            array of bytes
     * 
     * @return formatted string of bytes in hex form
     */
    public static String byteArrayToHexStringFormatted(byte[] rawBytes) 
    {
        StringBuffer sb = new StringBuffer();
        String s;
        int i = 0;

        for (byte b: rawBytes)
        {
            s = Integer.toHexString((int)b & 0xff);

            if (s.length() == 1)
                sb.append("0" + s + " ");
            else
                sb.append(s + " ");
            
            if ((++i) % 32 == 0)
                sb.append("\n");
        }
        return  sb.toString();    
    }

    /*-----------------------------------------------------------------------*/
    /*                            getBytesFromFile()                         */
    /*-----------------------------------------------------------------------*/
    /**
     * @param path
     *            is a path to the file
     * 
     * @return byte array of the file contents
     */
    public static byte[] getBytesFromFile(String path) 
                         throws IOException
    {
        File file = null;
        
        byte[] bytes = null;
        InputStream is = null;

        try 
        {
            // load the file from the specified location
            file = new File(path);
       
            if (file.canRead() && file.exists() && file.isFile()) 
            {
                is = new FileInputStream(file);
                long length = file.length();

                // Before reading in the file do a little error checking - make sure
                if (length == 0)
                    throw new IOException(file.getPath() + ":: is 0 bytes long");
                else if ((length > Integer.MAX_VALUE))
                    throw new IOException(file.getPath() + ":: is too long");

                bytes = new byte[(int) length];

                // Read in the bytes
                int offset = 0;
                int numRead = 0;
                while ((offset < bytes.length) && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) 
                {
                    offset += numRead;
                }

                // Ensure all the bytes have been read in
                if (offset < bytes.length) 
                    throw new IOException(file.getPath() + ":: could not read in complete file");
            }
            else
                throw new IOException(file.getPath() + ":: IO error");
        } 
        catch (Exception e) 
        {
            throw new IOException(e.toString(), e);
        }
        finally
        {
            // cleanup - close the input stream
            if (is != null)
                is.close();
        }
        return bytes;
    }
    
    /*-----------------------------------------------------------------------*/
    /*                                  main()                               */
    /*-----------------------------------------------------------------------*/
    /**
     * @param args
     * @throws IOException 
     */
    public static void main(String[] args) throws IOException
    {
        //String filepath = "/Users/rickbansal/Desktop/Amf-request-1.hex";
        //String filepath = "/Users/rickbansal/Desktop/Amf-response-1.hex";
        
        //String filepath = "/Users/rickbansal/Desktop/Williams-PoC-Sample-RR-pairs/login-request.hex";
        String filepath = "/Users/rickbansal/Desktop/Williams-PoC-Fiddler-hex-files/Amf-Response-3.hex";
        //String filepath = "/Users/rickbansal/Desktop/Williams-PoC-Sample-RR-pairs/sessionValidation-request.hex";
       //String filepath = "/Users/rickbansal/Desktop/Williams-PoC-Sample-RR-pairs/sessionValidation-response.hex";
        

        byte[] bytes = getBytesFromFile(filepath);
        
        //String xmlString = toXML(bytes);
                
        //System.out.println(xmlString);
        
        //xmlString = toXML(getBodyBytes(bytes));
        //System.out.println(xmlString);
        
        //byte[] amfBytes = toAMF(xmlString);
        
        //System.out.println(byteArrayToHexStringFormatted(amfBytes));

    }
}
