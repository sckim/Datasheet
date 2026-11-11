/*****************************************************************************
 * File Name : psp_nand.h 
 *
 * Brief	 : NAND interface definition 
 *
 * Copyright (C) 2009 -2010 Texas Instruments Incorporated - http://www.ti.com/ 
 * 
 * 
 *  Redistribution and use in source and binary forms, with or without 
 *  modification, are permitted provided that the following conditions 
 *  are met:
 *
 *    Redistributions of source code must retain the above copyright 
 *    notice, this list of conditions and the following disclaimer.
 *
 *    Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the 
 *    documentation and/or other materials provided with the   
 *    distribution.
 *
 *    Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
******************************************************************************/

#ifndef _PSP_NAND_H_
#define _PSP_NAND_H_

#include <psp_common.h>
#include <tistdtypes.h>

/* Dimensioning Configurable Elements */
#define PSP_NAND_NUM_INSTANCES              (1u)
/**< Number of NAND instances on the hardware.                              */
#define PSP_NAND_NUM_CHANNELS               (1u)
/**< Number of channels                                                     */
#define PSP_NAND_NUM_DEVICES_PER_CONTROLLER (1u)
/**< Max no. of slaves that can be connected on each NAND device instance.  */
#define PSP_NAND_TPOLL_MSECS                (100)
/**< Poll interval                                                          */


typedef Uint32 PSP_NandInstanceId;
/**< Instance Id of NAND on the SoC.                                        */

/**
 * \brief Configuration structure (operational mode) of NAND.
 *
 * Configuration information on
 *  - the current opMode,
 *  - the input clock frequency of NAND and
 *  - whether to erase NAND devices at initialization \n
 * can be configured by the user before the start of the driver.
 */
typedef struct {
    PSP_OpMode  opMode;
    /**< Mode of operation of NAND controller                               */
    Uint32      inputClkFreq;
    /**< Input clock frequency                                              */
    Uint8       eraseAtInit;
    /**< TRUE or 1 - Erase all NAND devices on board during initialization.\n
     * FALSE or 0 - No erase at startup or init.\n
     * - No selective erase supported. \n
     * <b> NOTE: TO BE USED WITH EXTREME CAUTION! </b>                      */
     /**< Handle for DMA                                                    */
} PSP_NandConfig;

/**
 * \brief Device Configuration structure of NAND.
 *
 * The following parameters are used, if the device ID
 * read from the device is not preset in the 'known' list
 * of device IDs.
 */
typedef struct {
    Int16            *name;
    /**< NAND Flash Name                        */
    Uint32          id;
    /**< NAND Flash Id                          */
    Uint32          bytesPerPage;
    /**< Bytes per page                         */
    Uint32          chipSize;
    /**< NAND Flash Total size                  */
    Uint32          eraseSize;
    /**< NAND Flash Erase size                  */
    Int             nand8Bit;
    /**< 8-bit or 16 bit                        */
    Uint32          nandOptions;
    /**< Extra cmds for Nand-Block              */
} PSP_NandFlashDev;

/**
 *  \brief  PSP NAND Ioctl commands
 *
 *  NAND Ioctl commands
 */
typedef enum
{
    PSP_NAND_IOCTL_GET_OPMODE,
    /**< Get the current opmode                 */
    PSP_NAND_IOCTL_GET_NAND_SIZE,
    /**< Get the size of NAND                   */
    PSP_NAND_IOCTL_GET_SECTOR_SIZE,
    /**< Get sector size of NAND                */
    PSP_NAND_IOCTL_SET_OPMODE,
    /**< Set the current opmode                 */
    PSP_NAND_IOCTL_CHECK_NAND,
    /**< NAND device(s) present?                */
    PSP_NAND_IOCTL_SET_CFG_PARAMS,
    /**< Set NAND configuration params          */
    PSP_NAND_IOCTL_MAX_IOCTL
    /**< Book-keep - Max ioctl's                */
} PSP_NandIoctlCmd;

/**
 *  \defgroup PSP NAND Error Codes
 *
 *  The following error codes are specific extensions for NAND device. These
 *  error code maps the low level error codes into PSP specific code.
 */
/*@{*/

#define PAL_ERROR_NANDRIVER(nanderr) \
    PAL_ERROR(PAL_CRITICAL_ERROR, PAL_ERROR_SRC_DRV, 0, nanderr)
/**< NAND error code definition                                             */
#define PSP_NAND_E_TIMEOUT               PAL_ERROR_NANDRIVER(1u)
/**< Read/Write/Erase operation timed out                                   */
#define PSP_NAND_E_INVALID_LSN           PAL_ERROR_NANDRIVER(2u)
/**< Invalid logical sector address                                         */
#define PSP_NAND_E_PAGE_READ_FAIL        PAL_ERROR_NANDRIVER(3u)
/**< Read operation failed                                                  */
#define PSP_NAND_E_PAGE_PROGRAM_FAIL     PAL_ERROR_NANDRIVER(4u)
/**< Write operation failed                                                 */
#define PSP_NAND_E_MEDIA_WRITE_PROTECTED PAL_ERROR_NANDRIVER(5u)
/**< Write/erase operation attempted on a write protected media             */
#define PSP_NAND_E_BLOCK_ERASE_FAIL      PAL_ERROR_NANDRIVER(6u)
/**< Erase operation failed                                                 */
#define PSP_NAND_E_ECC_ERROR             PAL_ERROR_NANDRIVER(7u)
/**< ECC verification failed                                                */
#define PSP_NAND_E_MEDIA_NOT_PRESENT     PAL_ERROR_NANDRIVER(8u)
/**< NAND flash media absent                                                */
#define PSP_NAND_E_INVALID_MEDIA         PAL_ERROR_NANDRIVER(9u)
/**< Invalid/unknownNAND flash media                                        */
#define PSP_NAND_E_OUT_OF_FREE_BLOCKS    PAL_ERROR_NANDRIVER(10u)
/**< NO free blocks available in NAND                                       */
#define PSP_NAND_E_SSFDC_ERROR           PAL_ERROR_NANDRIVER(11u)
/**< NAND driver is not SSFDC compliance                                    */
#define PSP_NAND_E_STATUS_READ_FAIL      PAL_ERROR_NANDRIVER(12u)
/**< Status read failed                                                     */
#define PSP_NAND_E_BAD_BLOCK             PAL_ERROR_NANDRIVER(13u)
/**< Block is BAD                                                           */
#define PSP_NAND_E_DMA_FAIL              PAL_ERROR_NANDRIVER(14u)
/**< DMA failed                                                             */
#define PSP_NAND_E_INVALID_PBA           PAL_ERROR_NANDRIVER(15u)
/**< Not a valid physical block address                                     */
#define PSP_NAND_E_NO_PAGE_EXIST         PAL_ERROR_NANDRIVER(16u)
/**< Page doesn't exist in the block                                        */
#define PSP_NAND_E_INVALID_DEVICE_ID    PAL_ERROR_NANDRIVER(17u)
/**< Not a valid device ID                                                  */

/*@} PSP NAND Error Codes */

#define PSP_NAND_EVENTQUEUE_USED   0
/**< EDMA Event Queue used                                      */


/**
 *  \brief Reads data from NAND instance.
 *
 *  This function reads 'xferRequest' bytes from the NAND device to 'buf',
 *  depending on the mode configured by the application. 'xferActual' holds
 *  the actual number of bytes read.
 *
 *  \param  hNand       [IN]    NAND Driver Instance Handle
 *  \param  logSector   [IN]    Sector to be read
 *  \param  pReadBuff   [OUT]   Character Buffer pointer - where read data is
 *                              to be stored
 *  \param  size        [IN]    Number of sector to be read
 *  \param  xferActual  [OUT]   Number of bytes actually transacted.
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result  PSP_nandReadSync(
                        PSP_Handle          hNand,
                        Uint32              logSector,
                        Uint16              * const pReadBuff,
                        Int32               size,
                        Int32               * const xferActual);

/**
 *  \brief Writes data to the NAND instance.
 *
 *  This function writes 'xferRequest' bytes to the NAND device from 'buf',
 *  depending on the mode configured by the application. 'xferActual' holds
 *  the actual number of bytes written.
 *
 *  \param  hNand       [IN]    NAND Driver Instance Handle
 *  \param  logSector   [IN]    Sector to be read
 *  \param  pWriteBuff  [OUT]   Character Buffer pointer - where read data is
 *                              to be stored
 *  \param  size        [IN]    Number of sector to be read
 *  \param  xferActual  [OUT]   Number of bytes actually transacted.
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result  PSP_nandWriteSync(
                        PSP_Handle          hNand,
                        Uint32              logSector,
                        Uint16              * const pWriteBuff,
                        Int32               size,
                        Int32               * const xferActual);


/**
 *  \brief Erases data on the NAND device.
 *
 *  API to be used with caution! This API erases all the blocks in the NAND
 *  and the action cannot be un-done. From a Filesystem perspective, this
 *  function formats the NAND device by calling the corresponding PSP layer
 *  API. This is an interface to the application.
 *
 *  \param  hNand       [IN]    NAND driver instance handle
 *
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result  PSP_nandErase(
                        PSP_Handle          hNand);

/**
 *  \brief Set the configuration parameters for new NAND device.
 *
 *  This API sets the following configuration parameters:
 *   Bytes per page,
 *   Pages per block,
 *   Size of NAND
 *   Bus Width: 8/16 bit.
 *  These parameters shall be used when the device ID read
 *  from the device doesn't match the one in the known 'list'.
 *
 *  <b>NOTE</b>: Use caution while setting these parameters, as they are
 *        used as-is while initializing the device.
 *
 *  \param  cfgParams   [IN]    Configuration parameter structure
 *
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result  PSP_nandAddDevice(
                        const PSP_NandFlashDev    *cfgParams);

/**
 *  \brief Initialize the device and the driver.
 *
 *  Called by the application, this API initializes the NAND
 *  device and the driver. It prepares the background for the
 *  driver to launch.
 *
 *  \param  instanceId  [IN]     NAND instance number
 *  \param  config      [IN]     Driver config information
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result PSP_nandInit(
                        PSP_NandInstanceId  instanceId,
                        const PSP_NandConfig      *config);

/**
 *  \brief Opens the NAND device instance.
 *
 *  Opens the device for transaction.
 *
 *  \param  instanceId  [IN]     NAND instance number
 *  \return PSP_Handle          Nand Driver Instance Handle
 */
PSP_Handle  PSP_nandOpen(
                        PSP_NandInstanceId  instanceId);

/**
 *  \brief Closes the NAND driver.
 *
 *  This API closes the driver that was opened by the Open call.
 *  Any specific objects that were created/used by the open call
 *  are freed here.
 *
 *  \param  hNand       [IN]    Nand Driver Instance Handle
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result PSP_nandClose(
                        PSP_Handle          hNand);
/**
 *  \brief Terminates a driver.
 *
 *  This function de-initializes and deletes the driver for a particular
 *  instance.
 *
 *  \param  instanceId  [IN]     NAND instance number.
 *  \return PSP_SOK or PSP Error code
 */
PSP_Result PSP_nandTerminate(
                        PSP_NandInstanceId  instanceId);

/**
 *  \brief IO Control for NAND controller.
 *
 *  This function supports various IOCTLs for the NAND controller.
 *
 *  \param  hNand       [IN]    NAND Driver Instance Handle
 *  \param  cmd         [IN]    IOCTL command
 *  \param  cmdArg      [IN]    Arguments, if any, for the command
 *  \param  param       [IN]    IOCTL specific parameter (driver specific).
 *  \return PSP_SOK or PSP Error code.
 */
PSP_Result  PSP_nandIoctl(
                        PSP_Handle          hNand,
                        PSP_NandIoctlCmd    cmd,
                        void *              cmdArg,
                        void *               param);

#endif  /* _PSP_NAND_H_ */

