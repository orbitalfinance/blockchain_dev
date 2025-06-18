// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title SimpleMessenger – salva e aggiorna un messaggio sulla blockchain
/// @author  (tuo nome)
/// @notice  Esempio didattico per Remix: storage vs memory, eventi, visibilità
contract SimpleMessenger {
    /* --------------------------------------------------------------------- *
     *  1. Stato                                                             *
     * --------------------------------------------------------------------- */

    /// @dev  Messaggio persistente (slot 0 dello storage)
    string private _message;

    /* --------------------------------------------------------------------- *
     *  2. Eventi                                                            *
     * --------------------------------------------------------------------- */

    /// @notice Emesso quando qualcuno cambia il messaggio
    /// @param oldMessage  Valore precedente
    /// @param newMessage  Nuovo valore
    event MessageChanged(string oldMessage, string newMessage);

    /* --------------------------------------------------------------------- *
     *  3. Costruttore                                                       *
     * --------------------------------------------------------------------- */

    /// @param initialMessage Messaggio iniziale salvato nello storage
    constructor(string memory initialMessage) {
        _message = initialMessage;
    }

    /* --------------------------------------------------------------------- *
     *  4. Funzioni di lettura                                               *
     * --------------------------------------------------------------------- */

    /// @notice Ritorna l’ultimo messaggio salvato (solo lettura)
    /// @return Il messaggio corrente
    function currentMessage() external view returns (string memory) {
        return _message;
    }

    /// @notice Un “Hello World” puro, senza accesso allo storage
    function helloConstant() external pure returns (string memory) {
        return "Hello World!";
    }

    /* --------------------------------------------------------------------- *
     *  5. Funzione di scrittura                                             *
     * --------------------------------------------------------------------- */

    /// @notice Aggiorna il messaggio permanente
    /// @param newMessage Il nuovo valore da registrare
    function updateMessage(string calldata newMessage) external {
        // salva il vecchio valore per l'evento
        string memory old = _message;

        // scrive nello storage (operazione che costa gas)
        _message = newMessage;

        // notifica gli ascoltatori off-chain
        emit MessageChanged(old, newMessage);
    }
}
