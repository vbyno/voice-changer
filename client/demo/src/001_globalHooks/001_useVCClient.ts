import { ClientState } from "@dannadori/voice-changer-client-js"
import { useClient } from "../../../lib/src/hooks/useClient"

export type UseVCClientProps = {
    audioContext: AudioContext | null
}

export type VCClientState = {
    clientState: ClientState
}

export const useVCClient = (props: UseVCClientProps): VCClientState => {
    console.log("++++++useVCClient");
    const clientState = useClient({
        audioContext: props.audioContext
    })

    const ret: VCClientState = {
        clientState
    }


    return ret

}
