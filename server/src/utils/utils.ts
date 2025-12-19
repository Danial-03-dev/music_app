import crypto from 'crypto';

export function getJWTSecret(): string {
    const SECRET = process.env.JWT_SECRET;
    return SECRET as string;
}

const algorithm = 'sha256';
const digest = 'hex';

export function signAudioUrl(audioId: string, expiresInSeconds = 60) {
    const SECRET = getJWTSecret();
    const exp = Math.floor(Date.now() / 1000) + expiresInSeconds;

    const payload = `${audioId}:${exp}`;
    const sig = crypto
        .createHmac(algorithm, SECRET)
        .update(payload)
        .digest(digest);

    return `audio/stream/${audioId}?exp=${exp}&sig=${sig}`;
}

export function validateAudioSignature(audioId: string, exp: string | undefined, sig: string | undefined) {
    const SECRET = getJWTSecret();

    if (!audioId) throw new Error('Missing audioId');

    if (!exp || !sig) {
        throw new Error('Missing signature or expiration');
    }

    const expNum = Number(exp);
    if (isNaN(expNum)) throw new Error('Invalid expiration');

    if (Date.now() / 1000 > expNum) {
        throw new Error('URL has expired');
    }

    const payload = `${audioId}:${exp}`;
    const expectedSig = crypto
        .createHmac(algorithm, SECRET)
        .update(payload)
        .digest(digest);

    if (
        typeof sig !== 'string' ||
        !crypto.timingSafeEqual(
            Buffer.from(sig),
            Buffer.from(expectedSig)
        )
    ) {
        throw new Error('Invalid signature');
    }
}
